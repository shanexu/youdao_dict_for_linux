use chrono::{DateTime, Local};
use dotenvy::dotenv;
use flutter_rust_bridge::frb;
use sqlx::{migrate::MigrateDatabase, sqlite::SqlitePoolOptions, Pool, Sqlite};
use std::{cell::LazyCell, env};

use super::service::WordResult;

#[frb]
pub struct History {
    pub id: i64,
    pub word: String,
    pub created_at: DateTime<Local>,
}

#[frb]
pub struct HistorySummary {
    pub word: String,
    pub count: i64,
}

#[frb]
pub struct WordCache {
    pub word: String,
    pub result: WordResult,
    pub updated_at: DateTime<Local>,
}

const DATABASE_URL: LazyCell<String> = LazyCell::new(|| {
    dotenv().ok();
    match env::var("DATABASE_URL") {
        Ok(v) => v,
        _ => home::home_dir()
            .map(|h| {
                format!(
                    "{}/.config/yd/database.db",
                    h.into_os_string().into_string().unwrap()
                )
            })
            .unwrap(),
    }
});

const POOL: LazyCell<Pool<Sqlite>> = LazyCell::new(|| {
    SqlitePoolOptions::new()
        .max_connections(5)
        .connect_lazy(&DATABASE_URL)
        .unwrap()
});

#[frb]
pub async fn init_db() -> anyhow::Result<()> {
    dotenv().ok();

    if !Sqlite::database_exists(&DATABASE_URL)
        .await
        .unwrap_or(false)
    {
        Sqlite::create_database(&DATABASE_URL).await?
    }
    let init_db_sql = "
CREATE TABLE IF NOT EXISTS `history`(
  `id` INTEGER NOT NULL PRIMARY KEY,
  `word` TEXT NOT NULL,
  `created_at` TIMESTAMP NOT NULL
);
CREATE TABLE IF NOT EXISTS `word_cache`(
  `word` TEXT NOT NULL PRIMARY KEY,
  `result` TEXT NOT NULL,
  `updated_at` TIMESTAMP NOT NULL
);
";
    sqlx::query(init_db_sql).execute(&(*POOL)).await?;
    Ok(())
}

#[frb]
pub async fn list_history() -> anyhow::Result<Vec<History>> {
    let rows: Vec<(i64, String, chrono::DateTime<Local>)> =
        sqlx::query_as("SELECT * from history ORDER BY created_at DESC")
            .fetch_all(&(*POOL))
            .await?;
    let histories = rows
        .into_iter()
        .map(|(id, word, created_at)| History {
            id,
            word,
            created_at,
        })
        .collect();
    Ok(histories)
}

#[frb]
pub async fn history_summary() -> anyhow::Result<Vec<HistorySummary>> {
    let rows: Vec<(String, i64)> = sqlx::query_as(
        "SELECT word,count(*) AS count FROM history GROUP BY word ORDER BY count DESC, word ASC",
    )
    .fetch_all(&(*POOL))
    .await?;
    let history_summaries = rows
        .into_iter()
        .map(|(word, count)| HistorySummary { word, count })
        .collect();
    Ok(history_summaries)
}

#[frb]
pub async fn create_history(word: &str) -> anyhow::Result<i64> {
    let local_time: DateTime<Local> = Local::now();
    let id = sqlx::query("INSERT INTO history (word, created_at) VALUES (?,?)")
        .bind(word)
        .bind(local_time)
        .execute(&(*POOL))
        .await?
        .last_insert_rowid();
    Ok(id)
}

#[frb]
pub async fn delete_history(id: i64) -> anyhow::Result<()> {
    sqlx::query("DELETE from history WHERE id = ?")
        .bind(id)
        .execute(&(*POOL))
        .await?;
    Ok(())
}

#[frb]
pub async fn upsert_word_cache(word: &str, result: &WordResult) -> anyhow::Result<()> {
    let local_time: DateTime<Local> = Local::now();
    sqlx::query("INSERT OR REPLACE INTO word_cache (word, result, updated_at) VALUES (?, ?, ?)")
        .bind(word)
        .bind(serde_json::to_string(result).unwrap())
        .bind(local_time)
        .execute(&(*POOL))
        .await?;
    Ok(())
}

#[frb]
pub async fn get_word_cache(word: &str) -> anyhow::Result<Option<WordCache>> {
    let opt_result: Option<(String, String, DateTime<Local>)> =
        sqlx::query_as("select * from word_cache where word = ?")
            .bind(word)
            .fetch_optional(&(*POOL))
            .await?;
    let opt_word_cache = opt_result.map(|(word, result_json, updated_at)| {
        let result = serde_json::from_str(&result_json).unwrap();
        WordCache {
            word,
            result,
            updated_at,
        }
    });
    Ok(opt_word_cache)
}

#[cfg(test)]
mod test {
    use chrono::Local;
    use sqlx::{migrate::MigrateDatabase, sqlite::SqlitePoolOptions, Sqlite};

    #[tokio::test(flavor = "multi_thread", worker_threads = 1)]
    async fn test_hello() {
        let url = "sqlite:///home/shane/.config/yd/database.db";
        if !Sqlite::database_exists(url).await.unwrap_or(false) {
            Sqlite::create_database(url)
                .await
                .expect("create database failed");
        }
        let pool = SqlitePoolOptions::new()
            .max_connections(5)
            .connect_lazy(url)
            .unwrap();
        let rows: Vec<(i64, String, chrono::DateTime<Local>)> =
            sqlx::query_as("SELECT * from history order by created_at desc")
                .fetch_all(&pool)
                .await
                .unwrap();

        for row in rows {
            println!("{:?}", row)
        }
    }
}

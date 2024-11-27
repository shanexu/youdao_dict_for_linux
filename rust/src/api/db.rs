use chrono::{DateTime, Local};
use dotenvy::dotenv;
use flutter_rust_bridge::frb;
use sqlx::{migrate::MigrateDatabase, sqlite::SqlitePoolOptions, Pool, Sqlite};
use std::{cell::LazyCell, env};

#[frb]
pub struct History {
    pub id: i64,
    pub word: String,
    pub created_at: DateTime<Local>,
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
    Ok(())
}

#[frb]
pub async fn list_history() -> anyhow::Result<Vec<History>> {
    let rows: Vec<(i64, String, chrono::DateTime<Local>)> =
        sqlx::query_as("SELECT * from history order by created_at desc")
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

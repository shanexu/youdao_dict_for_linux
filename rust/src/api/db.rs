pub struct History {
    pub id: i64,
    pub word: String,
    pub created_at: chrono::NaiveDateTime,
}

#[cfg(test)]
mod test {
    use sqlx::{migrate::MigrateDatabase, sqlite::SqlitePoolOptions, Sqlite};

    #[tokio::test(flavor = "multi_thread", worker_threads = 1)]
    async fn test_hello() {
        let url = "/home/shane/.config/yd/database.db";
        if !Sqlite::database_exists(url).await.unwrap_or(false) {
            Sqlite::create_database(url)
                .await
                .expect("create database failed");
        }
        let pool = SqlitePoolOptions::new()
            .max_connections(5)
            .connect(url)
            .await
            .unwrap();
        let rows: Vec<(i64, String, chrono::NaiveDateTime)> =
            sqlx::query_as("SELECT * from history order by created_at desc")
                .fetch_all(&pool)
                .await
                .unwrap();

        for row in rows {
            println!("{:?}", row)    
        }        
    }
}

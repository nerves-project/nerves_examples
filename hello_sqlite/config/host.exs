import Config

# Add configuration that is only needed when running on the host here.

config :hello_sqlite,
  ecto_repos: [HelloSqlite.Repo]

config :hello_sqlite, HelloSqlite.Repo,
  database: "/tmp/hello_sqlite.db",
  show_sensitive_data_on_connection_error: false,
  journal_mode: :wal,
  cache_size: -64000,
  temp_store: :memory,
  pool_size: 1

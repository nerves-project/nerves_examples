defmodule HelloSqlite.Repo do
  use Ecto.Repo, otp_app: :hello_sqlite, adapter: Ecto.Adapters.SQLite3
end

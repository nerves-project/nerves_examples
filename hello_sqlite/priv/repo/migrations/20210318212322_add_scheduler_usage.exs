defmodule HelloSqlite.Repo.Migrations.AddSchedulerUsage do
  use Ecto.Migration

  def change do
    create table(:scheduler_usage) do
      add :total_util, :float
      add :total_percent, :float
      timestamps()
    end
  end
end

defmodule HelloSqlite.SchedulerUsage do
  use Ecto.Schema

  schema "scheduler_usage" do
    field :total_util, :float
    field :total_percent, :float
    timestamps()
  end
end

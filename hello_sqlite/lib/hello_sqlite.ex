defmodule HelloSqlite do
  @moduledoc """
  Sqlite demo application
  """

  @spec save_usage() :: :ok
  defdelegate save_usage(), to: HelloSqlite.SchedulerUsagePoller

  @spec print_recent(non_neg_integer()) :: :ok
  defdelegate print_recent(count \\ 5), to: HelloSqlite.SchedulerUsagePoller
end

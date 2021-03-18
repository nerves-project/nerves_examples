defmodule HelloSqlite.SchedulerUsagePoller do
  use GenServer
  require Logger
  alias HelloSqlite.{Repo, SchedulerUsage}
  import Ecto.Query

  @doc """
  Pretty prints entries from the Scheduler Usage table
  """
  def print_recent(entries) do
    rows =
      Repo.all(
        from su in SchedulerUsage,
          order_by: [desc: su.id],
          limit: ^entries,
          select: [su.inserted_at, su.total_percent, su.total_util]
      )

    header = ["Timestamp", "Percent", "Util"]
    title = "Scheduler Usage"

    TableRex.quick_render!(rows, header, title)
    |> IO.puts()
  end

  @doc false
  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  @impl GenServer
  def init(_args) do
    {:ok, nil, 0}
  end

  @impl GenServer
  def handle_info(:timeout, state) do
    util = :scheduler.utilization(1)
    {:total, total_util, total_percent_str} = :lists.keyfind(:total, 1, util)
    {total_percent, "%"} = Float.parse(to_string(total_percent_str))

    %SchedulerUsage{
      total_percent: total_percent,
      total_util: total_util
    }
    |> Repo.insert!()

    {:noreply, state, 30_000}
  end
end

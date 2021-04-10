defmodule HelloSqlite.SchedulerUsagePoller do
  @moduledoc """
  Saves scheduler utilization to Sqlite every 30 seconds or whenever
  `save_usage/1` is called.
  """

  use GenServer
  require Logger
  alias HelloSqlite.{Repo, SchedulerUsage}
  import Ecto.Query

  @timeout 30_000

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

  def save_usage do
    GenServer.call(__MODULE__, :save_usage)
  end

  @impl GenServer
  def init(_args) do
    # A timeout of 0 is passed here so that we'll receive a `:timeout` message
    # immediately after starting up
    # More info: https://hexdocs.pm/elixir/GenServer.html#module-timeouts
    {:ok, nil, 0}
  end

  @impl GenServer
  def handle_call(:save_usage, _from, state) do
    do_save_usage()

    {:reply, :ok, state, @timeout}
  end

  @impl GenServer
  def handle_info(:timeout, state) do
    do_save_usage()

    {:noreply, state, @timeout}
  end

  defp do_save_usage do
    util = :scheduler.utilization(1)
    {:total, total_util, total_percent_str} = :lists.keyfind(:total, 1, util)
    {total_percent, "%"} = Float.parse(to_string(total_percent_str))

    %SchedulerUsage{
      total_percent: total_percent,
      total_util: total_util
    }
    |> Repo.insert!()
  end
end

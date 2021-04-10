defmodule HelloSqlite.SchedulerUsagePoller do
  @moduledoc """
  Saves scheduler utilization to Sqlite every 30 seconds or whenever
  `save_usage/1` is called.
  """

  use GenServer

  alias HelloSqlite.{Repo, SchedulerUsage}
  import Ecto.Query

  @timeout 30_000

  @doc false
  @spec start_link(keyword()) :: GenServer.on_start()
  def start_link(init_args) do
    GenServer.start_link(__MODULE__, init_args, name: __MODULE__)
  end

  @doc """
  Pretty print entries from the Scheduler Usage table
  """
  @spec print_recent(non_neg_integer()) :: :ok
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

  @doc """
  Manually trigger a usage record to be saved
  """
  @spec save_usage() :: :ok
  def save_usage() do
    GenServer.call(__MODULE__, :save_usage)
  end

  @impl GenServer
  def init(_init_args) do
    {:ok, _tref} = :timer.send_interval(@timeout, :tick)

    # Save something so there's always at least one row
    # in the table for the demo.
    do_save_usage()

    {:ok, nil}
  end

  @impl GenServer
  def handle_call(:save_usage, _from, state) do
    do_save_usage()

    {:reply, :ok, state}
  end

  @impl GenServer
  def handle_info(:tick, state) do
    do_save_usage()

    {:noreply, state}
  end

  defp do_save_usage() do
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

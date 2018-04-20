defmodule DistributedBlinky.NodeConnector do
  @moduledoc false
  require Logger
  use GenServer

  @timeout 10000

  def start_link do
    GenServer.start_link __MODULE__, []
  end

  def init([]) do
    {:ok, [], @timeout}
  end

  # node list is empty, connect!
  def handle_info(_,[]) do
    for l <- get_nodes() do
      Node.connect(l)
    end
    {:noreply, Node.list(), @timeout}
  end

  # node list is not empty, we're good!
  def handle_info(_,_) do
    {:noreply, Node.list(), @timeout}
  end

  defp get_nodes do
    Application.get_env(:distributed_blinky, :initial_nodes, [])
  end

end

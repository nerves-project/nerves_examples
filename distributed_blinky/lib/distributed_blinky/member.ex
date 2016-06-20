defmodule DistributedBlinky.Member do
  @moduledoc false
  use GenServer
  require Logger

  @timeout 5000

  defstruct [:identifier, :initialized]

  def start_link do
    GenServer.start_link __MODULE__, []
  end

  def init([]) do
    send self, :join
    {:ok, %__MODULE__{identifier: identifier(), initialized: false} }
  end

  def handle_info(:join, state) do
    DistributedBlinky.PubSub.subscribe

    {:noreply, state, @timeout}
  end

  # everything turned silent
  def handle_info(:timeout, state) do
    node_list()
    |> case do
        [h | _] = l when length(l) > 1 ->
          Logger.debug "Timed out... (re-)init!"
          DistributedBlinky.PubSub.broadcast %{action: :init, host: identifier(h)}
        _ ->
          :ok
      end
    {:noreply, %__MODULE__{ state | initialized: false}, @timeout}
  end

  # somebody broadcasted init and we're not initialized, blink!
  def handle_info(%{action: :init, host: id}, %{identifier: id, initialized: false} = state) do
    Logger.debug "init #{id}"
    DistributedBlinky.Led.blink_once

    # find the next based on my own identifier
    id
    |> find_next()
    |> broadcast_next()

    {:noreply, %__MODULE__{ state | initialized: true}, @timeout}
  end

  # init is broadcasted, but we're already initialized, disregard
  def handle_info(%{action: :init}, state) do
    {:noreply, state, @timeout}
  end

  # next is me, blink!
  def handle_info(%{ action: :next, host: id }, %{identifier: id} = state) do
    Logger.debug "next #{id}"
    DistributedBlinky.Led.blink_once

    # find the next based on my own identifier
    id
    |> find_next()
    |> broadcast_next()

    {:noreply, state, @timeout}
  end

  # it's not init or it's not me
  def handle_info(_msg, state) do
    {:noreply, state, @timeout}
  end

  # create the node list including self
  defp node_list() do
    [ Node.self | Node.list ]
    |> Enum.sort
  end

  # helper function to turn first part of own nodename in integer
  defp identifier() do
    Node.self
    |> identifier
  end

  # helper function to turn first part of any nodename in integer
  defp identifier(nodename) when is_atom(nodename) do
    nodename
    |> Atom.to_string
    |> identifier
  end

  defp identifier(nodename) do
    nodename
    |> String.split("@")
    |> hd
    |> String.to_integer
  end

  # find next identifier in node list
  defp find_next(id) do
    [h|t] = node_list()

    next = Enum.find(t, fn(n) ->
      (identifier(n) > id) == true
    end)

    if is_nil(next) do
      h
    else
      next
    end
    |> identifier()
    |> case do
      ^id -> nil
      found -> found
    end
  end

  # broadcast the next identifier
  defp broadcast_next(id) do
    DistributedBlinky.PubSub.broadcast %{ action: :next, host: id }
  end

end

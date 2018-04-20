defmodule DistributedBlinky.PubSub do
  @moduledoc false

  @topic "blinky"

  def subscribe do
    Phoenix.PubSub.subscribe __MODULE__, @topic
  end

  def broadcast(msg) do
    Phoenix.PubSub.broadcast __MODULE__, @topic, msg
  end

end

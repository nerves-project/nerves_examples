defmodule DistributedBlinky.Led do
  @moduledoc false
  alias Nerves.IO.Led

  @led :green

  def blink_once(ms \\ 1000) do
    Led.set [{@led, true}]
    :timer.sleep ms
    Led.set [{@led, false}]
  end

end

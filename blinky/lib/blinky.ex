defmodule Blinky do

  alias Nerves.IO.Led
  require Logger

  def start(_type, _args) do
    blink_forever
  end

  def blink_forever do
    Led.set green: true, red: false
    Logger.info "green"
    :timer.sleep 100
    Led.set red: true, green: false
    Logger.info "red"
    :timer.sleep 100
    blink_forever
  end

end

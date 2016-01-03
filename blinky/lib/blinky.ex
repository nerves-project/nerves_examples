defmodule Blinky do

  @moduledoc """
  Simple example to blink a list of LEDs forever.   
  
  The list of LEDs is platform-dependent, and defined in the config
  directory (see config.exs).   See README.md for build instructions.
  """

  alias Nerves.IO.Led
  require Logger

  def start(_type, _args) do
    led_list = Application.get_env(:blinky, :led_list)
    Logger.debug "list of leds to blink is #{inspect led_list}"
    spawn fn -> blink_list_forever(led_list) end
    {:ok, self}
  end

  # call blink_led on each led in the list sequence, repeating forever
  defp blink_list_forever(led_list) do
    Enum.each(led_list, &blink(&1))
    blink_list_forever(led_list)
  end

  # given an led key, turn it on for 100ms then back off
  defp blink(led_key) do
    Logger.debug "blinking led #{inspect led_key}"
    Led.set [{led_key, true}]
    :timer.sleep 100
    Led.set [{led_key, false}]
  end

end
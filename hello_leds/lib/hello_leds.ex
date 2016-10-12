defmodule HelloLeds do

  @moduledoc """
  Simple example to blink a list of LEDs forever.

  The list of LEDs is platform-dependent, and defined in the config
  directory (see config.exs).   See README.md for build instructions.
  """

  @on_duration  200 # ms
  @off_duration 200 # ms

  alias Nerves.Leds
  require Logger

  def start(_type, _args) do
    led_list = Application.get_env(:hello_leds, :led_list)
    Logger.debug "list of leds to blink is #{inspect led_list}"
    Enum.each(led_list, &start_blink(&1))
    {:ok, self}
  end

  # Set led `led_key` to the state defined below. It is also possible
  # to globally define states in `config/config.exs` by passing a list
  # of states with the `:states` keyword.
  #
  # The first parameter must be an atom.
  @spec start_blink(Keyword.T) :: true
  defp start_blink(led_key) do
    Logger.debug "blinking led #{inspect led_key}"
    # led_key is a variable that contains an atom
    Leds.set [{
      led_key,
      [
        trigger: "timer",
        delay_off: @off_duration,
        delay_on: @on_duration
      ]
    }]
  end
end

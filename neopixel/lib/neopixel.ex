defmodule Neopixel do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    ch0_config = Application.get_env(:neopixel, :channel0)
    ch1_config = Application.get_env(:neopixel, :channel1)

    spawn(fn -> start_animations(ch0_config, ch1_config) end)

    # Define workers and child supervisors to be supervised
    children = [
      worker(Nerves.Neopixel, [ch0_config, ch1_config])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Neopixel.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp start_animations(ch0_config, _ch1_config) do
    Process.sleep(1000)
    Neopixel.Animate.spinner(0, ch0_config[:count])
    # Neopixel.Animate.pulse(1, ch1_config[:count])
  end
end

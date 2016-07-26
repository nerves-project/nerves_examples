defmodule Neopixel do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    ch0_config = Application.get_env(:neopixel, :channel0)
    ch1_config = Application.get_env(:neopixel, :channel1)

    # Define workers and child supervisors to be supervised
    children = [
      worker(Nerves.Neopixel, [ch0_config, ch1_config]),
      #worker(Task, [fn -> Neopixel.Animate.spinner(0, ch0_config[:count], color: {0, 0, 255}) end], id: :spinner),
      #worker(Task, [fn -> Neopixel.Animate.pulse(1, ch1_config[:count], color: {0, 0, 255}) end], id: :pulse)
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Neopixel.Supervisor]
    Supervisor.start_link(children, opts)
  end

end

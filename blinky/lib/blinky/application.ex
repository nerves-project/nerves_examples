defmodule Blinky.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    delux_options = Application.get_all_env(:blinky)
    Logger.debug("Blinky: target-specific options for Delux: #{inspect(delux_options)}")

    children = [
      # See https://hexdocs.pm/delux
      {Delux, delux_options ++ [initial: Delux.Effects.blink(:on, 2)]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Blinky.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

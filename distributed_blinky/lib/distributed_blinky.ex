defmodule DistributedBlinky do
  @moduledoc false
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    if_eth0 = Application.get_env(:distributed_blinky, :if_eth0) || []

    # Define workers and child supervisors to be supervised
    children = [
      supervisor(Phoenix.PubSub.PG2, [DistributedBlinky.PubSub, [pool_size: 1]]),
      worker(DistributedBlinky.Member, []),
      worker(Nerves.Networking, [:eth0, if_eth0], function: :setup),
      worker(DistributedBlinky.NodeConnector, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DistributedBlinky.Supervisor]
    Supervisor.start_link(children, opts)
  end

end

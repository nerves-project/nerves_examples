defmodule HelloPhoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  defdelegate target(), to: Nerves.Runtime, as: :mix_target

  @impl true
  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloPhoenix.Supervisor]

    children =
      [
        # Start the Ecto repository
        HelloPhoenix.Repo,
        # Start the Telemetry supervisor
        HelloPhoenixWeb.Telemetry,
        # Start the PubSub system
        {Phoenix.PubSub, name: HelloPhoenix.PubSub},
        # Start the Endpoint (http/https)
        HelloPhoenixWeb.Endpoint,
        # Run migrations on start
        {Task, &HelloPhoenix.MigrationHelpers.migrate/0}
        # Children for all targets
        # Starts a worker by calling: HelloPhoenix.Worker.start_link(arg)
        # {HelloPhoenix.Worker, arg},
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HelloPhoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: HelloPhoenix.Worker.start_link(arg)
      # {HelloPhoenix.Worker, arg},
    ]
  end

  def children(_target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: HelloPhoenix.Worker.start_link(arg)
      # {HelloPhoenix.Worker, arg},
    ]
  end
end

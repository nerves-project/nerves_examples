defmodule Ui.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      UiWeb.Telemetry,
      Ui.Repo,
      {DNSCluster, query: Application.get_env(:ui, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Ui.PubSub},
      # Start a worker by calling: Ui.Worker.start_link(arg)
      # {Ui.Worker, arg},
      # Start to serve requests, typically the last entry
      UiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ui.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    UiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

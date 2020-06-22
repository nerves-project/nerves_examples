defmodule HelloZig.Application do
  # empty, placeholder application.
  @moduledoc false
  use Application
  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: HelloZig.Supervisor]
    Supervisor.start_link([], opts)
  end
end

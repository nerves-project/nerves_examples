defmodule HelloScenic do
  @moduledoc """
  Starter application using the Scenic framework.
  """

  def start(_type, _args) do
    # load the viewport configuration from config
    main_viewport_config = Application.get_env(:hello_scenic, :viewport)

    # start the application with the viewport
    children = [
      {Scenic, [main_viewport_config]},
      HelloScenic.PubSub.Supervisor
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end

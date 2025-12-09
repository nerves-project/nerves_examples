defmodule HelloLiveViewWeb.Home do
  use HelloLiveViewWeb, :live_view
  import HelloLiveViewWeb.TextComponents

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.page_title title="Hello, LiveView!" />
      <.body>
        Click to learn more about <.link href="https://nerves-project.org">Nerves</.link>
        and <.link href="https://www.phoenixframework.org/">LiveView</.link>.
      </.body>
    </Layouts.app>
    """
  end
end

defmodule HelloLiveViewWeb.Home do
  use HelloLiveViewWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.page_title title="Hello, LiveView!" />
    <.body>
      Click to learn more about
      <.link_to href="https://nerves-project.org">Nerves</.link_to>
      and
      <.link_to href="https://www.phoenixframework.org/">LiveView</.link_to>.
    </.body>
    """
  end
end

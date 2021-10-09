defmodule UiWeb.PageLive do
  use UiWeb, :live_view

  @refresh_interval_ms 1000

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    socket = assign(socket, current_time_second: System.monotonic_time(:second))

    if connected?(socket) do
      schedule_refresh()
    end

    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def handle_info(:tick, socket) do
    schedule_refresh()
    socket = assign(socket, current_time_second: System.monotonic_time(:second))

    {:noreply, socket}
  end

  defp schedule_refresh() do
    Process.send_after(self(), :tick, @refresh_interval_ms)
  end
end

defmodule UiWeb.PageLive do
  use UiWeb, :live_view

  @refresh_interval_ms 1000

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(current_time_second: System.monotonic_time(:second))
      |> assign(serial_number: get_serial_number())

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

  defp get_serial_number() do
    case Code.ensure_loaded(Nerves.Runtime) do
      {:module, _} -> Nerves.Runtime.serial_number()
      _error -> "Unavailable"
    end
  end
end

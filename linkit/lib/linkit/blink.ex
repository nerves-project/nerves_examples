defmodule Linkit.Blink do
  use GenServer

  @interval 1000

  def start_link(module, opts \\ []) do
    GenServer.start_link(__MODULE__, {module, opts})
  end

  def init({module, opts}) do
    interval = opts[:interval] || @interval
    s =
      init(%{}, module)
      |> Map.put(:timer, Process.send_after(self, :interval, interval))
    {:ok, s}
  end

  def init(s, :firmata) do
    {:ok, pid} = Linkit.Firmata.start_link()
    Map.put(s, :firmata, pid)
  end

  def init(s, :gpio) do
    :os.cmd '/usr/bin/pinmux set ephy gpio'
    {:ok, pid} = Gpio.start_link(43, :output)
    Map.put(s, :gpio, {pid, 0})
  end

  def init(s, :both) do
    s
    |> init(:firmata)
    |> init(:gpio)
  end

  def handle_info(:interval, %{gpio: {pid, state}} = s) do
    s = state_change(s)
    timer = Process.send_after(self, :interval, s.interval)
    {:noreply, %{s | timer: timer}}
  end

  defp state_change(%{gpio: _, firmata: _} = s) do
    s
    |> state_change(:gpio)
    |> state_change(:firmata)
  end
  defp state_change(%{gpio: _} = s), do: state_change(:gpio, s)
  defp state_change(%{firmata: _} = s), do: state_change(:firmata, s)

  defp state_change(%{firmata: {firmata, state}} = s, :firmata) do
    state =
      if state == 0, do: 1, else: 0
    Linkit.Firmata.digital_write(pid, 13, state)
    %{s | firmata: {pid, state}}
  end

  defp state_change(%{gpio: {pid, state}}, :gpio) do
    state = if state == 0, do: 1, else: 0
    Gpio.write(pid, state)
    %{s | gpio: {pid, state}}
  end


end

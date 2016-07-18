defmodule Linkit.Firmata do
  use GenServer
  use Firmata.Protocol.Modes
  alias Firmata.Board, as: Board

  @high 1
  @low 0

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], opts)
  end

  def digital_write(pid, pin, state) do
    GenServer.call(pid, {:digital_write, pin, state})
  end

  def init([]) do
    {:ok, serial} = Nerves.UART.start_link
    {:ok, board}  = Board.start_link
    Nerves.UART.open(serial, "ttyS0", speed: 57600, active: true)
    Nerves.UART.write(serial, <<0xFF>>)
    Nerves.UART.write(serial, <<0xF9>>)
    {:ok, %{board: board, serial: serial}}
  end

  def handle_call({:digital_write, pin, state}, _from, s) do
    Board.digital_write(s.board, pin, state)
    {:reply, :ok, s}
  end

  def handle_info({:nerves_uart, _, data}, s) do
    IO.puts "Data in: #{inspect data}"
    send(s.board, {:serial, data})
    {:noreply, s}
  end

  def handle_info({:firmata, {:send_data, data}}, s) do
    IO.puts "Data out: #{inspect data}"
    Nerves.UART.write(s.serial, data)
    {:noreply, s}
  end

  def handle_info({:firmata, {:version, major, minor}}, s) do
    IO.puts "Firmware Version: v#{major}.#{minor}"
    {:noreply, s}
  end

  def handle_info({:firmata, {:firmware_name, name}}, s) do
    IO.puts "Firmware Name: #{name}"
    {:noreply, s}
  end

  def handle_info({:firmata, {:pin_map, _pin_map}}, s) do
    IO.puts "Ready"

    Board.set_pin_mode(s.board, 13, @output)

    {:noreply, s}
  end
end

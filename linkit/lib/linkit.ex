defmodule Linkit do

  def start(_type, _args) do
    {:ok, self}
  end

  def blink(:gpio) do
    :os.cmd '/usr/bin/pinmux set ephy gpio'
    {:ok, pid} = Gpio.start_link(43, :output)
    gpio_blink(pid)
  end


  def blink(:firmata) do
    {:ok, pid} = Linkit.Firmata.start_link()
    spawn(fn -> firmata_blink(pid) end)
  end

  def blink() do
    spawn(fn -> firmata_blink(pid) end)
  end

  defp gpio_blink(pid) do
    Gpio.write(pid, 1)
    :timer.sleep 1000
    Gpio.write(pid, 0)
    :timer.sleep 1000
  end

  defp firmata_blink(pid) do
    Linkit.Firmata.digital_write(pid, 13, 0)
    :timer.sleep 1000
    Linkit.Firmata.digital_write(pid, 13, 1)
    :timer.sleep 1000
    firmata_blink(pid)
  end

end

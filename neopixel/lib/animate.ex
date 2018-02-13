defmodule Neopixel.Animate do
  alias Nerves.Neopixel

  def spinner(ch, pixels, opts \\ []) do
    color = opts[:color] || {0, 255, 0}
    delay = opts[:delay] || 100
    data = [color, color, color] ++ List.duplicate({0, 0, 0}, pixels - 3)

    spawn(fn -> spin_indef(ch, data, delay) end)
  end

  def spin_indef(ch, data, delay) do
    Neopixel.render(ch, {125, data})
    [h | t] = data
    :timer.sleep(delay)
    spin_indef(ch, t ++ [h], delay)
  end

  def pulse(ch, pixels, opts \\ []) do
    color = opts[:color] || {212, 175, 55}
    delay = opts[:delay] || 100

    data = List.duplicate(color, pixels)
    spawn(fn -> pulse_indef(ch, data, delay, 0, :up) end)
  end

  def pulse_indef(ch, data, delay, 0, :down) do
    pulse_indef(ch, data, delay, 1, :up)
  end

  def pulse_indef(ch, data, delay, 125, :up) do
    pulse_indef(ch, data, delay, 124, :down)
  end

  def pulse_indef(ch, data, delay, brightness, direction) do
    Neopixel.render(ch, {brightness, data})
    :timer.sleep(delay)
    brightness = if direction == :up, do: brightness + 1, else: brightness - 1
    pulse_indef(ch, data, delay, brightness, direction)
  end
end

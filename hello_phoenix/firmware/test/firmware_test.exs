defmodule FirmwareTest do
  use ExUnit.Case
  doctest Firmware

  test "greets the world" do
    assert Firmware.hello() == :world
  end
end

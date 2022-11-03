defmodule FirmwareTest do
  use ExUnit.Case
  doctest Firmware

  test "greets the world" do
    assert Firmware.hello() == :world
  end

  test "greets the Ui" do
    assert Firmware.hello_ui() == :world
  end

  test "gets a list of users" do
    assert Firmware.list_users == []
  end
end

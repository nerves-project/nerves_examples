defmodule HelloSnmpManagerTest do
  use ExUnit.Case
  doctest HelloSnmpManager

  test "greets the world" do
    assert HelloSnmpManager.hello() == :world
  end
end

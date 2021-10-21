defmodule HelloSnmpAgentTest do
  use ExUnit.Case
  doctest HelloSnmpAgent

  test "greets the world" do
    assert HelloSnmpAgent.hello() == :world
  end
end

defmodule HelloPhoenixTest do
  use ExUnit.Case
  doctest HelloPhoenix

  test "greets the world" do
    assert HelloPhoenix.hello() == :world
  end
end

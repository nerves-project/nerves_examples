defmodule MinimalTest do
  use ExUnit.Case
  doctest Minimal

  test "greets the world" do
    assert Minimal.hello() == :world
  end
end

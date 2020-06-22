defmodule HelloZigTest do
  use ExUnit.Case

  test "greets the world" do
    assert HelloZig.hello() == :world
  end
end

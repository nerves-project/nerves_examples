defmodule HelloLfeTest do
  use ExUnit.Case
  doctest HelloLfe

  test "greets the world" do
    assert HelloLfe.hello() == :world
  end
end

defmodule HelloDistributionTest do
  use ExUnit.Case
  doctest HelloDistribution

  test "greets the world" do
    assert HelloDistribution.hello() == :world
  end
end

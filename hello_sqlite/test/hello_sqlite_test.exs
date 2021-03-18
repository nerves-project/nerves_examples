defmodule HelloSqliteTest do
  use ExUnit.Case
  doctest HelloSqlite

  test "greets the world" do
    assert HelloSqlite.hello() == :world
  end
end

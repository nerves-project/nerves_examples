defmodule TemplateTest do
  use ExUnit.Case
  doctest Template

  test "greets the world" do
    assert Template.hello() == :world
  end
end

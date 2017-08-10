defmodule BahnExTest do
  use ExUnit.Case
  doctest BahnEx

  test "greets the world" do
    assert BahnEx.hello() == :world
  end
end

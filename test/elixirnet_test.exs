defmodule ElixirnetTest do
  use ExUnit.Case
  doctest Elixirnet

  test "greets the world" do
    assert Elixirnet.hello() == :world
  end
end

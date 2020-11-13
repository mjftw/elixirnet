defmodule Matrex.CoordinatesTest do
  use ExUnit.Case
  import Matrex.Coordinates

  test "coordinates/1 returns correct values" do
    assert Matrex.zeros(2, 3) |> coordinates() == [{0, 0}, {0, 1}, {0, 2}, {1, 0}, {1, 1}, {1, 2}]
  end
end

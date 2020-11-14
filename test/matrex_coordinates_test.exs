defmodule Matrex.CoordinatesTest do
  use ExUnit.Case
  import Matrex.Coordinates

  test "coordinates/1 returns correct values" do
    assert Matrex.zeros(2, 3) |> coordinates() == [{0, 0}, {0, 1}, {0, 2}, {1, 0}, {1, 1}, {1, 2}]
  end

  test "submatrix_at/3 returns correct values" do
    matrix = 1..8 * 8
    |> Enum.to_list
    |> Matrex.reshape(8, 8)

    submatrix = matrix
    |> submatrix_at({4, 5}, {3, 5})

    expected = [
      28.0, 29.0, 30.0, 31.0, 32.0,
      36.0, 37.0, 38.0, 39.0, 40.0,
      44.0, 45.0, 46.0, 47.0, 48.0
    ]
    |> Matrex.reshape(3, 5)

    assert submatrix == expected
  end

  test "submatrix_at/3 raises error on out of bounds access" do
    assert_raise RuntimeError, fn ->
      Matrex.zeros(5)
      |> submatrix_at({0, 0}, {3, 3})
    end
  end

  test "submatrix_at/3 raises error on even submatrix rows" do
    assert_raise RuntimeError, fn ->
      Matrex.zeros(5)
      |> submatrix_at({2, 2}, {2, 3})
    end
  end

  test "submatrix_at/3 raises error on even submatrix cols" do
    assert_raise RuntimeError, fn ->
      Matrex.zeros(5)
      |> submatrix_at({2, 2}, {3, 2})
    end
  end
end

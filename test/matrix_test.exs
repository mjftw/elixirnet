defmodule MatrixTest do
  use ExUnit.Case

  doctest(Matrix)

  test "Matrix.at/1 gets correct element" do
    assert %Matrix{shape: {3}, data: [1, 2, 3]}
    |> Matrix.at(2) == 3
  end

  test "Matrix.at/1 raises exception on out of bound access" do
    assert_raise RuntimeError, fn ->
      assert %Matrix{shape: {1}, data: [1, 2, 3]}
      |> Matrix.at(1) == 3
    end
  end

  @tag :skip
  test "Matrix.at/2 gets correct element" do
    assert %Matrix{shape: {2, 3}, data: [1, 2, 3, 4, 5, 6]}
    |> Matrix.at(0, 1) == 4
  end

  test "Matrix.at/2 raises exception on out of bounds x access" do
    assert_raise RuntimeError, fn ->
      assert %Matrix{shape: {1, 2}, data: [1, 2, 3, 4]}
      |> Matrix.at(1, 0) == 3
    end
  end

  test "Matrix.at/2 raises exception on out of bounds y access" do
    assert_raise RuntimeError, fn ->
      assert %Matrix{shape: {2, 1}, data: [1, 2, 3, 4]}
      |> Matrix.at(0, 1) == 3
    end
  end

  @tag :skip
  test "Matrix.at/3 gets correct element" do
    assert %Matrix{shape: {2, 2, 2}, data: [1, 2, 3, 4, 5, 6, 7, 8]}
    |> Matrix.at(0, 1, 0) == 3
  end

  test "Matrix.at/3 raises exception on out of bounds x access" do
    assert_raise RuntimeError, fn ->
      assert %Matrix{shape: {1, 2, 2}, data: [1, 2, 3, 4, 5, 6]}
      |> Matrix.at(1, 0, 0) == 3
    end
  end

  test "Matrix.at/3 raises exception on out of bounds y access" do
    assert_raise RuntimeError, fn ->
      assert %Matrix{shape: {2, 1, 2}, data: [1, 2, 3, 4, 5, 6]}
      |> Matrix.at(0, 1, 0) == 3
    end
  end

  test "Matrix.at/3 raises exception on out of bounds z access" do
    assert_raise RuntimeError, fn ->
      assert %Matrix{shape: {2, 2, 1}, data: [1, 2, 3, 4, 5, 6]}
      |> Matrix.at(0, 0, 1) == 3
    end
  end
end

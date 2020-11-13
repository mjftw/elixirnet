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
    assert %Matrix{shape: {2, 3}, data: [1..6]}
    |> Matrix.at(0, 1) == 4
  end

  test "Matrix.at/2 raises exception on out of bounds x access" do
    assert_raise RuntimeError, fn ->
      assert %Matrix{shape: {1, 2}, data: [1..4]}
      |> Matrix.at(1, 0) == 3
    end
  end

  test "Matrix.at/2 raises exception on out of bounds y access" do
    assert_raise RuntimeError, fn ->
      assert %Matrix{shape: {2, 1}, data: [1..4]}
      |> Matrix.at(0, 1) == 3
    end
  end

  @tag :skip
  test "Matrix.at/3 gets correct element" do
    assert %Matrix{shape: {2, 2, 2}, data: [1..8]}
    |> Matrix.at(0, 1, 0) == 3
  end

  test "Matrix.at/3 raises exception on out of bounds x access" do
    assert_raise RuntimeError, fn ->
      assert %Matrix{shape: {1, 2, 2}, data: [1..6]}
      |> Matrix.at(1, 0, 0) == 3
    end
  end

  test "Matrix.at/3 raises exception on out of bounds y access" do
    assert_raise RuntimeError, fn ->
      assert %Matrix{shape: {2, 1, 2}, data: [1..6]}
      |> Matrix.at(0, 1, 0) == 3
    end
  end

  test "Matrix.at/3 raises exception on out of bounds z access" do
    assert_raise RuntimeError, fn ->
      assert %Matrix{shape: {2, 2, 1}, data: [1..6]}
      |> Matrix.at(0, 0, 1) == 3
    end
  end

  test "zeros/1 creates Matrix of correct size" do
    assert length(Matrix.zeros(3).data) == 3
  end

  test "zeros/1 creates Matrix of all zeros" do
    assert Matrix.zeros(3).data
    |> Enum.reduce(true, &(&1 == 0 and &2 == true))
  end

  test "zeros/2 creates Matrix of correct size" do
    assert length(Matrix.zeros(3, 2).data) == 6
  end

  test "zeros/2 creates Matrix of all zeros" do
    assert Matrix.zeros(3, 2).data
    |> Enum.reduce(true, &(&1 == 0 and &2 == true))
  end

  test "zeros/3 creates Matrix of correct size" do
    assert length(Matrix.zeros(3, 2, 4).data) == 24
  end

  test "zeros/3 creates Matrix of all zeros" do
    assert Matrix.zeros(3, 2, 4).data
    |> Enum.reduce(true, &(&1 == 0 and &2 == true))
  end

  test "ones/1 creates Matrix of correct size" do
    assert length(Matrix.ones(3).data) == 3
  end

  test "ones/1 creates Matrix of all ones" do
    assert Matrix.ones(3).data
    |> Enum.reduce(true, &(&1 == 1 and &2 == true))
  end

  test "ones/2 creates Matrix of correct size" do
    assert length(Matrix.ones(3, 2).data) == 6
  end

  test "ones/2 creates Matrix of all ones" do
    assert Matrix.ones(3, 2).data
    |> Enum.reduce(true, &(&1 == 1 and &2 == true))
  end

  test "ones/3 creates Matrix of correct size" do
    assert length(Matrix.ones(3, 2, 4).data) == 24
  end

  test "ones/3 creates Matrix of all ones" do
    assert Matrix.ones(3, 2, 4).data
    |> Enum.reduce(true, &(&1 == 1 and &2 == true))
  end
end

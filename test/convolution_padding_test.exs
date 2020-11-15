defmodule Convolution.Padding.PaddingTest do
  use ExUnit.Case
  import Convolution.Padding

  test "num_pad_cols/3 calculates correct padding amount - square filter, stride 0" do
    assert num_pad_cols(Matrex.magic(10), Matrex.magic(5), 1) == 2
  end

  test "num_pad_cols/3 calculates correct padding amount - rect filter, stride 0" do
    assert num_pad_cols(Matrex.random(10), Matrex.random(3, 7), 1) == 3
  end

  test "num_pad_cols/3 calculates correct padding amount - rect filter, stride 3" do
    assert num_pad_cols(Matrex.random(10), Matrex.random(3, 7), 3) == 12
  end

  test "num_pad_rows/3 calculates correct padding amount - square filter, stride 0" do
    assert num_pad_rows(Matrex.magic(10), Matrex.magic(5), 1) == 2
  end

  test "num_pad_rows/3 calculates correct padding amount - rect filter, stride 0" do
    assert num_pad_rows(Matrex.random(10), Matrex.random(3, 7), 1) == 1
  end

  test "num_pad_rows/3 calculates correct padding amount - rect filter, stride 3" do
    assert num_pad_rows(Matrex.random(10), Matrex.random(7, 5), 3) == 12
  end

  test "Padding.constant/3 output is correct size for square input and filter" do
    assert constant(Matrex.magic(10), Matrex.magic(5), 0)[:size] == {14, 14}
  end

  test "Padding.constant/3 output is correct size for square input and rectagle filter" do
    assert constant(Matrex.random(10, 10), Matrex.random(3, 7), 0)[:size] == {12, 16}
  end

  test "Padding.constant/3 output is correct size for rectangle input and rectagle filter" do
    assert constant(Matrex.random(10, 20), Matrex.random(3, 7), 0)[:size] == {12, 26}
  end

  test "Padding.constant/3 output has all correct values" do
    output = constant(Matrex.ones(10), Matrex.magic(5), 1)
    assert Matrex.max(output) == 1 and Matrex.min(output) == 1
  end

  test "Padding.constant/4 output is correct size for square input and filter, stride 3" do
    assert constant(Matrex.magic(10), Matrex.magic(5), 3, 0)[:size] == {32, 32}
  end

  test "Padding.constant/4 output is correct size for square input and rectagle filter, stride 3" do
    assert constant(Matrex.magic(10), Matrex.random(3, 7), 3, 0)[:size] == {30, 34}
  end

  test "Padding.constant/4 output is correct size for rectangle input and filter, stride 3" do
    assert constant(Matrex.random(10, 20), Matrex.random(3, 7), 3, 0)[:size] == {30, 64}
  end

  test "Padding.constant/4 output has all correct values" do
    output = constant(Matrex.ones(10), Matrex.magic(5), 3, 2)
    assert Matrex.max(output) == 2 and Matrex.min(output) == 1
  end

  test "Padding.same/2 output is correct size" do
    assert same(Matrex.magic(10), Matrex.magic(5))[:size] == {14, 14}
  end

  test "Padding.same/3 output is correct size, stride 2" do
    assert same(Matrex.magic(10), Matrex.magic(5), 3)[:size] == {32, 32}
  end

  test "Padding.same/2 output is padded with all zeros" do
    output = same(Matrex.zeros(10), Matrex.zeros(5))
    assert Matrex.max(output) == 0 and Matrex.min(output) == 0
  end
end

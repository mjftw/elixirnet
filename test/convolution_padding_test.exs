defmodule Convolution.Padding.PaddingTest do
  use ExUnit.Case
  import Convolution.Padding

  test "Padding.none/1 padding returns input" do
    m = Matrex.magic(5)
    assert none(m) == m
  end
  test "Padding.none/2 padding returns input" do
    m = Matrex.magic(5)
    assert none(m, :ignored) == m
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

  test "Padding.zero/2 output is correct size" do
    assert zero(Matrex.magic(10), Matrex.magic(5))[:size] == {14, 14}
  end

  test "Padding.zero/3 output is correct size, stride 2" do
    assert zero(Matrex.magic(10), Matrex.magic(5), 3)[:size] == {32, 32}
  end

  test "Padding.zero/2 output is padded with all zeros" do
    output = zero(Matrex.zeros(10), Matrex.zeros(5))
    assert Matrex.max(output) == 0 and Matrex.min(output) == 0
  end
end

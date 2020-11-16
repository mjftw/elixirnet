defmodule ConvolutionTest do
  use ExUnit.Case
  import Convolution
  alias Convolution.Padding

  test "convolve/3 returns correct output with :same padding, ones" do
    input  = Matrex.ones({5, 5})
    kernel = Matrex.ones({3, 3})

    expected = [
      4.0, 6.0, 6.0, 6.0, 4.0,
      6.0, 9.0, 9.0, 9.0, 6.0,
      6.0, 9.0, 9.0, 9.0, 6.0,
      6.0, 9.0, 9.0, 9.0, 6.0,
      4.0, 6.0, 6.0, 6.0, 4.0
    ] |> Matrex.reshape(5, 5)

    assert convolve(input, kernel, :same) == expected
  end

  test "convolve/4 returns output with correct size, :same padding, stride 2, ones" do
    input  = Matrex.ones({3, 7})
    kernel = Matrex.ones({3, 3})

    assert convolve(input, kernel, :same, 2)[:size] == input[:size]
  end

  test "convolve/4 returns output with correct size, :same padding, stride 5, ones" do
    input  = Matrex.ones({30, 18})
    kernel = Matrex.ones({5, 3})

    assert convolve(input, kernel, :same, 5)[:size] == input[:size]
  end

  test "convolve/3 returns correct output, :same padding, stride 2, ones" do
    input  = Matrex.ones({5, 5})
    kernel = Matrex.ones({3, 3})

    expected = [
      0, 0, 0, 0, 0,
      0, 4, 6, 4, 0,
      0, 6, 9, 6, 0,
      0, 4, 6, 4, 0,
      0, 0, 0, 0, 0
    ] |> Matrex.reshape(5, 5)

    assert convolve(input, kernel, :same, 2) == expected
  end

  test "convolve/3 returns correct output, :same padding, stride 2, accending" do
    input  = 1..5 * 5 |> Enum.to_list |> Matrex.reshape(5, 5)
    kernel = 1..3 * 3 |> Enum.to_list |> Matrex.reshape(3, 3)

    expected = [
      0,   0,   0,   0, 0,
      0, 128, 241, 184, 0,
      0, 441, 681, 453, 0,
      0, 320, 457, 280, 0,
      0,   0,   0,   0, 0
    ] |> Matrex.reshape(5, 5)

    assert convolve(input, kernel, :same, 2) == expected
  end

  test "convolve/3 returns correct output with :same padding, accending values" do
    input  = 1..5 * 5 |> Enum.to_list |> Matrex.reshape(5, 5)
    kernel = 1..3 * 3 |> Enum.to_list |> Matrex.reshape(3, 3)

    expected = [
      128.0, 202.0, 241.0, 280.0, 184.0,
      276.0, 411.0, 456.0, 501.0, 318.0,
      441.0, 636.0, 681.0, 726.0, 453.0,
      606.0, 861.0, 906.0, 951.0, 588.0,
      320.0, 436.0, 457.0, 478.0, 280.0
    ] |> Matrex.reshape(5, 5)

    assert convolve(input, kernel, :same) == expected
  end

  test "convolve/3 returns output with correct size on large matrices with :same padding" do
    input = Matrex.zeros(262, 191)
    kernel = Matrex.zeros(19, 27)

    assert convolve(input, kernel, :same)[:size] == input[:size]
  end

  test "convolve/2 uses :valid padding" do
    input  = 1..5 * 5 |> Enum.to_list |> Matrex.reshape(5, 5)
    kernel = 1..3 * 3 |> Enum.to_list |> Matrex.reshape(3, 3)

    assert convolve(input, kernel) == convolve(input, kernel, :valid)
  end

  test "convolve/3 returns output with correct size with :valid padding, ones" do
    input  = Matrex.ones({5, 5})
    kernel = Matrex.ones({3, 3})

    assert convolve(input, kernel, :valid)[:size] == {3, 3}
  end

  test "convolve/3 returns correct output :valid padding, ones" do
    input  = Matrex.ones({5, 5})
    kernel = Matrex.ones({3, 3})

    assert convolve(input, kernel, :valid) == Matrex.fill(3, 9.0)
  end

  test "convolve/3 returns correct output with :valid padding, accending values" do
    input  = 1..5 * 5 |> Enum.to_list |> Matrex.reshape(5, 5)
    kernel = 1..3 * 3 |> Enum.to_list |> Matrex.reshape(3, 3)

    expected = [
      411.0, 456.0, 501.0,
      636.0, 681.0, 726.0,
      861.0, 906.0, 951.0
    ] |> Matrex.reshape(3, 3)

    assert convolve(input, kernel, :valid) == expected
  end

  test "convolve/4 returns output with correct size with :valid padding, stride 2" do
    input  = Matrex.ones({7, 9})
    kernel = Matrex.ones({3, 1})

    assert convolve(input, kernel, :valid, 2)[:size] == {3, 5}
  end

  test "convolve/4 returns correct output with :valid padding, stride 2" do
    input  = Matrex.ones({7, 7})
    kernel = Matrex.ones({3, 3})

    assert convolve(input, kernel, :valid, 2) == Matrex.fill(3, 9)
  end

  test "convolve/4 returns output with correct size with :valid padding, stride 2, rectangle" do
    input  = Matrex.ones({7, 7})
    kernel = Matrex.ones({3, 3})

    assert convolve(input, kernel, :valid, 2)[:size] == {3, 3}
  end

  test "convolve/4 returns output with smaller size with :valid padding when stride too high to fit cleanly" do
    input  = Matrex.ones({7, 7})
    kernel = Matrex.ones({3, 3})

    assert convolve(input, kernel, :valid, 4)[:size] == {2, 2}
  end

  test "max_pool/2 returns correct output, accending values" do
    input  = 1..5 * 5 |> Enum.to_list |> Matrex.reshape(5, 5)
    kernel = 1..3 * 3 |> Enum.to_list |> Matrex.reshape(3, 3)

    expected = [
      13, 14, 15,
      18, 19, 20,
      23, 24, 25
    ] |> Matrex.reshape(3, 3)

    assert max_pool(input, kernel) == expected
  end

end

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

    assert Convolution.convolve(input, kernel, :same) == expected
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

    assert Convolution.convolve(input, kernel, :same) == expected
  end

  test "convolve/3 returns output with correct size on large matrices with :same padding" do
    input = Matrex.zeros(262, 191)
    kernel = Matrex.zeros(19, 27)

    assert Convolution.convolve(input, kernel, :same)[:size] == input[:size]
  end

  test "convolve/3 returns correct output with correct size with :valid padding, ones" do
    input  = Matrex.ones({5, 5})
    kernel = Matrex.ones({3, 3})

    assert Convolution.convolve(input, kernel, :valid)[:size] == {3, 3}
  end

  test "convolve/3 returns correct output :valid padding, ones" do
    input  = Matrex.ones({5, 5})
    kernel = Matrex.ones({3, 3})

    assert Convolution.convolve(input, kernel, :valid) == Matrex.fill(3, 9.0)
  end

  test "convolve/3 returns correct output with :valid padding, accending values" do
    input  = 1..5 * 5 |> Enum.to_list |> Matrex.reshape(5, 5)
    kernel = 1..3 * 3 |> Enum.to_list |> Matrex.reshape(3, 3)

    expected = [
      411.0, 456.0, 501.0,
      636.0, 681.0, 726.0,
      861.0, 906.0, 951.0
    ] |> Matrex.reshape(3, 3)

    assert Convolution.convolve(input, kernel, :valid) == expected
  end

end

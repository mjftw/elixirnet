defmodule ConvolutionTest do
  use ExUnit.Case
  import Convolution
  alias Convolution.Padding

  test "convolve/3 returns correct output with same padding, ones" do
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
end

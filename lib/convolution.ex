defmodule Convolution do
  @moduledoc """
  Module for handling convolution of two matrices.
  """

  alias Convolution.Padding

  @doc """
  Perform a sliding window style convoltion over an input matrix and a kernel matrix
  using "same"/"same" padding
  """
  @spec convolve(Matrex.t(), Matrex.t()):: Matrex.t()
  def convolve(input, kernel), do: convolve(input, kernel, :same)

  @doc """
  Perform a sliding window style convoltion over an input matrix and a kernel matrix.
  Atom argument donotes what kind of padding should be applied during the convolution.
  """
  @spec convolve(Matrex.t(), Matrex.t(), :same) :: Matrex.t()
  def convolve(input, kernel, :same) do
    IO.inspect(kernel)

    input_padded = Padding.same(input, kernel)

    # Slide a kernel sized window over the input matrix and perform dot product
    # between the windowed matrix section and the convolution kernel at each location.
    # Each dot product forms the new value for the output matrix.
    coords = Matrex.Extra.coordinates(input)

    coords
    |> Enum.map(fn {row, col} -> {
      row + Padding.num_pad_rows(input, kernel, 1),
      col + Padding.num_pad_cols(input, kernel, 1)} end)
    |> Enum.map(
        fn coord -> Matrex.Extra.submatrix_at(input_padded, coord, kernel[:size])
        |> Matrex.multiply(kernel)
        |> Matrex.sum()
      end)
    |> Matrex.reshape(input[:rows], input[:cols])

  end
end

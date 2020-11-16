defmodule Convolution do
  @moduledoc """
  Module for handling convolution of two 2d matrices.
  """

  alias Convolution.Padding

  @typedoc """
  The different methods avalaible to the convolution functions.
  :valid - output is smaller than the input (no padding)
  :same - output is the same size as the input (zero padding)
  :same - output is the same size as the input (constant padding)
  """
  @type conv_method :: :valid | :same | :fill

  @doc """
  Perform a sliding window style convoltion over an input matrix and a kernel matrix.
  Uses "valid" padding method.
  """
  @spec convolve(Matrex.t(), Matrex.t()) :: Matrex.t()
  def convolve(input, kernel), do: convolve(input, kernel, :valid)

  @doc """
  Perform a sliding window style convoltion over an input matrix and a kernel matrix.
  Atom argument donotes what kind of padding should be applied during the convolution.
  """
  @spec convolve(Matrex.t(), Matrex.t(), conv_method) :: Matrex.t()
  def convolve(input, kernel, method) do
    {input_padded, {row_offset, col_offset}, {output_rows, output_cols}} =
      pad_input(input, kernel, method)

    # Slide a kernel sized window over the input matrix and perform dot product
    # between the windowed matrix section and the convolution kernel at each location.
    # Each dot product forms the new value for the output matrix.
    Matrex.zeros(output_rows, output_cols)
    |> Matrex.apply(fn _, row, col ->
      Matrex.Extra.submatrix_at(
        input_padded,
        {row + row_offset, col + col_offset},
        kernel[:size]
      )
      |> Matrex.multiply(kernel)
      |> Matrex.sum()
    end)
  end

  @typedoc """
  Tuple returned from the pad_input functions containing the padded matrix and additional info
  required to perform the convolution.
  """
  @type padding_return :: {Matrex.t(), {non_neg_integer, non_neg_integer}, {non_neg_integer, non_neg_integer}}

  @spec pad_input(Matrex.t(), Matrex.t(), :valid) :: padding_return
  defp pad_input(input, kernel, :valid) do
    row_offset = ceil((kernel[:rows] - 1) / 2) - 1
    col_offset = ceil((kernel[:cols] - 1) / 2) - 1

    output_rows = input[:rows] - kernel[:rows] + 1
    output_cols = input[:cols] - kernel[:cols] + 1

    {input, {row_offset, col_offset}, {output_rows, output_cols}}
  end

  @spec pad_input(Matrex.t(), Matrex.t(), :same) :: padding_return
  defp pad_input(input, kernel, :same), do: pad_input(input, kernel, :constant, 0)

  @spec pad_input(Matrex.t(), Matrex.t(), :constant, number) :: padding_return
  defp pad_input(input, kernel, :constant, value) do
    input_padded = Padding.constant(input, kernel, value)

    row_offset = Padding.num_pad_rows(input, kernel, 1) - 1
    col_offset = Padding.num_pad_cols(input, kernel, 1) - 1

    {input_padded, {row_offset, col_offset}, {input[:rows], input[:cols]}}
  end
end

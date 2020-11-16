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
  @type conv_method :: :valid | :same | :constant

  @doc """
  Performconvoltion over an input matrix and a kernel matrix.
  Uses "valid" padding method, with a stride of 1.
  """
  @spec convolve(Matrex.t(), Matrex.t()) :: Matrex.t()
  def convolve(input, kernel), do: convolve(input, kernel, :valid)

  @doc """
  Performconvoltion over an input matrix and a kernel matrix.
  Uses "constant" padding, with the value being specified like {:constant, 5}
  """
  @spec convolve(Matrex.t(), Matrex.t(), {:constant, number}, non_neg_integer) :: Matrex.t()
  def convolve(_, _, _, stride \\ 1)
  def convolve(input, kernel, {:constant, pad_value}, stride),
    do: apply_to_window(input, kernel, &sum_products/2, :constant, stride, pad_value)

  @doc """
  Perform a sliding window style convoltion over an input matrix and a kernel matrix.
  Atom argument donotes what kind of padding should be applied during the convolution.
  """
  @spec convolve(Matrex.t(), Matrex.t(), conv_method, non_neg_integer) :: Matrex.t()
  def convolve(input, kernel, method, stride),
  do: apply_to_window(input, kernel, &sum_products/2, method, stride)

  @doc """
  Peform max pooling on the `input` matrix, with the pooling size taken to be the size of the
  `kernel` matrix provided.

  Optionally stride value can also be given. This defaults to 1.
  """
  @spec max_pool(Matrex.t(), Matrex.t(), non_neg_integer) :: Matrex.t()
  def max_pool(input, kernel, stride \\ 1),
    do: apply_to_window(input, kernel, fn (m, _) -> Matrex.max(m) end, :valid, stride)

  @doc """
  Slide a `kernel` matrix across the `input` matrix, and apply a function `func` between the
  kernel and the windowed section of the input at each position, computing a single value.
  The values produced form the output matrix, with the value taking the position of the center
  of the windowed section.
  The function passed in should take windowed input image section as its first argument, and the
  kernel as its second.

  By default, the "valid" padding scheme is applied, and the output matrix will be smaller than the
  input. Other padding methods can be used:
    :same - output is same size as input, pad border with zeros
    :constant - output is same size as input, pad border with a given `pad_fill` value

  Optionally, a stride value can also be given. This defaults to 1.
  """
  @spec apply_to_window(
          Matrex.t(),
          Matrex.t(),
          (Matrex.t(), Matrex.t() -> number),
          conv_method,
          non_neg_integer,
          number
        ) :: Matrex.t()
  def apply_to_window(input, kernel, func, pad_method \\ :valid, stride \\ 1, pad_fill \\ 0) do
    {input_padded, {row_offset, col_offset}, {output_rows, output_cols}} =
      pad_input(input, kernel, pad_method, stride, pad_fill)

    Matrex.zeros(output_rows, output_cols)
    |> Matrex.apply(fn _, row, col ->
      Matrex.Extra.submatrix_at(
        input_padded,
        {(row - 1) * stride + row_offset, (col - 1) * stride + col_offset},
        kernel[:size]
      )
      |> func.(kernel)
    end)
  end

  @spec sum_products(Matrex.t(), Matrex.t()) :: number
  defp sum_products(matrix1, matrix2) do
    matrix1
    |> Matrex.multiply(matrix2)
    |> Matrex.sum()
  end

  @typedoc """
  Tuple returned from the pad_input functions containing the padded matrix and additional info
  required to perform the convolution.
  """
  @type padding_return ::
          {Matrex.t(), {non_neg_integer, non_neg_integer}, {non_neg_integer, non_neg_integer}}

  @spec pad_input(Matrex.t(), Matrex.t(), :valid, non_neg_integer, any) :: padding_return
  defp pad_input(input, kernel, :valid, stride, _) do
    row_offset = ceil((kernel[:rows] - 1) / 2)
    col_offset = ceil((kernel[:cols] - 1) / 2)

    output_rows = floor((input[:rows] - kernel[:rows]) / stride) + 1
    output_cols = floor((input[:cols] - kernel[:cols]) / stride) + 1

    {input, {row_offset, col_offset}, {output_rows, output_cols}}
  end


  @spec pad_input(Matrex.t(), Matrex.t(), :constant,  non_neg_integer, number) :: padding_return
  defp pad_input(input, kernel, :constant, stride, value) do
    input_padded = Padding.constant(input, kernel, stride, value)

    row_offset = Padding.num_pad_rows(input, kernel, 1)
    col_offset = Padding.num_pad_cols(input, kernel, 1)

    {input_padded, {row_offset, col_offset}, {input[:rows], input[:cols]}}
  end

  @spec pad_input(Matrex.t(), Matrex.t(), :same,  non_neg_integer, any) :: padding_return
  defp pad_input(input, kernel, :same, stride, _), do: pad_input(input, kernel, :constant, stride, 0)
end

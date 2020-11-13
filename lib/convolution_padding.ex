defmodule Convolution.Padding do
  import Matrex

  @doc """
  No padding is applied. Also known as "valid" padding.
  """
  @spec none(Matrex.t(), any) :: Matrex.t()
  def none(input, _), do: none(input)
  @spec none(Matrex.t()) :: Matrex.t()
  def none(input), do: input

  @doc """
  Padding is applied to ensure the output of a convolution is the same size as
  the input by padding the input with zeros. Also known as "same" padding.
  """
  @spec zero(Matrex.t(), Matrex.t()) :: Matrex.t()
  def zero(input, kernel), do: constant(input, kernel, 1, 0)
  @spec zero(Matrex.t(), Matrex.t(), non_neg_integer) :: Matrex.t()
  def zero(input, kernel, stride), do: constant(input, kernel, stride, 0)

  @doc """
  The same as "same" padding, except a given value is used for the padding.
  """
  @spec constant(Matrex.t(), Matrex.t(), number) :: Matrex.t()
  def constant(input, kernel, value), do: constant(input, kernel, 1, value)
  @spec constant(Matrex.t(), Matrex.t(), non_neg_integer, number) :: Matrex.t()
  def constant(input, kernel, stride, value) do
    row_pad_num = ceil(((stride - 1) * input[:rows] - stride + kernel[:rows]) / 2)
    col_pad_num = ceil(((stride - 1) * input[:cols] - stride + kernel[:cols]) / 2)

    col_pad = Matrex.fill(input[:rows], col_pad_num, value)
    input_col_padded = col_pad
    |> Matrex.concat(input, :columns)
    |> Matrex.concat(col_pad, :columns)

    row_pad = Matrex.fill(row_pad_num, input_col_padded[:cols], value)
    row_pad
    |> Matrex.concat(input_col_padded, :rows)
    |> Matrex.concat(row_pad, :rows)
  end


  @doc """
  Pads the input with a reflection of the values directly opposite in the input.
  """
  @spec reflection(Matrex.t(), Matrex.t(), non_neg_integer) :: Matrex.t()
  def reflection(input, kernel, stride) do
    raise "Not implemented"
  end
end

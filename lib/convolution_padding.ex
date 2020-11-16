defmodule Convolution.Padding do
  @moduledoc """
    Adds functionality for adding padding to Matrex module matrices ready for
    performing a convolution operation.
  """

  @doc """
  Padding is applied to ensure the output of a convolution is the same size as
  the input by padding the input with zeros. Also known as "zero" padding.
  """
  @spec same(Matrex.t(), Matrex.t()) :: Matrex.t()
  def same(input, kernel), do: constant(input, kernel, 1, 0)
  @spec same(Matrex.t(), Matrex.t(), non_neg_integer) :: Matrex.t()
  def same(input, kernel, stride), do: constant(input, kernel, stride, 0)

  @doc """
  The same as "same" padding, except a given value is used for the padding.
  """
  @spec constant(Matrex.t(), Matrex.t(), number) :: Matrex.t()
  def constant(input, kernel, value), do: constant(input, kernel, 1, value)
  @spec constant(Matrex.t(), Matrex.t(), non_neg_integer, number) :: Matrex.t()
  def constant(input, kernel, stride, value) do
    col_pad = Matrex.fill(input[:rows], num_pad_cols(input, kernel, stride), value)

    input_col_padded =
      col_pad
      |> Matrex.concat(input, :columns)
      |> Matrex.concat(col_pad, :columns)

    row_pad = Matrex.fill(num_pad_rows(input, kernel, stride), input_col_padded[:cols], value)

    row_pad
    |> Matrex.concat(input_col_padded, :rows)
    |> Matrex.concat(row_pad, :rows)
  end

  @doc """
  Calculate amount of padding to be added on left and right of input for "same" padding
  """
  @spec num_pad_cols(Matrex.t(), Matrex.t(), non_neg_integer) :: Matrex.t()
  def num_pad_cols(input, kernel, stride), do: num_pad(input, kernel, stride, :cols)

  @doc """
  Calculate amount of padding to be added on top and bottome of input for "same" padding
  """
  @spec num_pad_rows(Matrex.t(), Matrex.t(), non_neg_integer) :: Matrex.t()
  def num_pad_rows(input, kernel, stride), do: num_pad(input, kernel, stride, :rows)

  @spec num_pad(Matrex.t(), Matrex.t(), non_neg_integer, atom) :: Matrex.t()
  defp num_pad(input, kernel, stride, axis_atom) do
    ceil(((stride - 1) * input[axis_atom] - stride + kernel[axis_atom]) / 2)
  end
end

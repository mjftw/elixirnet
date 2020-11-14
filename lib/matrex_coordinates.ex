defmodule Matrex.Coordinates do
  @doc """
  Get a list of tuples of x, y coordinates for a matrix.
  """
  @spec coordinates(Matrex.t()) :: [any]
  def coordinates(matrix) do
    matrix
    |> Enum.with_index()
    |> Enum.map(fn {_, idx} -> {div(idx, matrix[:cols]), rem(idx, matrix[:cols])} end)
  end

  @doc """
  Extract a submatrix, with the extraction centered at a given coordinate,
  and with a given width and height.
  """
  @spec submatrix_at(
          Matrex.t(),
          {non_neg_integer, non_neg_integer},
          {non_neg_integer, non_neg_integer}
        ) :: Matrex.t()
  def submatrix_at(_, _, {width, height}) when rem(width, 2) == 0 or rem(height, 2) == 0 do
    raise "Submatrix width and height must be odd numbers"
  end

  def submatrix_at(matrix, {center_x, center_y}, {width, height}) do
    x_sides = (width - 1) / 2
    y_sides = (height - 1) / 2

    matrix
    |> Matrex.submatrix(
    trunc(center_x + 1 - x_sides)..trunc(center_x + 1 + x_sides),
    trunc(center_y + 1 - y_sides)..trunc(center_y + 1 + y_sides))
  end
end

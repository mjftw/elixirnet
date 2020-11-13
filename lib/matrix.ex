defmodule Matrix do
  defstruct data: [], shape: {}

  # 1d Matrix
  @spec at(Matrix, non_neg_integer) :: any
  def at(%Matrix{shape: {shape_x}}, x)
      when x >= shape_x,
      do: raise("Matrix index out of bounds")

  def at(matrix, x), do: Enum.at(matrix.data, x)

  # 2d Matrix
  @spec at(Matrix, non_neg_integer, non_neg_integer) :: any
  def at(%Matrix{shape: {shape_x, shape_y}}, x, y)
      when x >= shape_x or y >= shape_y,
      do: raise("Matrix index out of bounds")

  def at(matrix, x, y), do: Enum.at(matrix.data, elem(matrix.shape, 1) * y + x)

  # 3d Matrix
  def at(%Matrix{shape: {shape_x, shape_y, shape_z}}, x, y, z)
      when x >= shape_x or y >= shape_y or z >= shape_z,
      do: raise("Matrix index out of bounds")

  @spec at(Matrix, non_neg_integer, non_neg_integer, non_neg_integer) :: any
  def at(matrix, x, y, z),
    do:
      Enum.at(
        matrix.data,
        elem(matrix.shape, 1) * elem(matrix.shape, 2) * z + elem(matrix.shape, 2) * y + x
      )

  # new
  @spec new(non_neg_integer, any) :: Matrix.t()
  def new(shape_x, value), do: %Matrix{data: List.duplicate(value, shape_x), shape: {shape_x}}

  @spec new(integer, integer, any) :: Matrix.t()
  def new(shape_x, shape_y, value),
    do: %Matrix{data: List.duplicate(value, shape_x * shape_y), shape: {shape_x, shape_y}}

  @spec new(integer, integer, integer, any) :: Matrix.t()
  def new(shape_x, shape_y, shape_z, value),
    do: %Matrix{
      data: List.duplicate(value, shape_x * shape_y * shape_z),
      shape: {shape_x, shape_y, shape_z}
    }

  # zeros
  @spec zeros(non_neg_integer) :: Matrix.t()
  def zeros(shape_x), do: new(shape_x, 0)

  @spec zeros(non_neg_integer, non_neg_integer) :: Matrix.t()
  def zeros(shape_x, shape_y), do: new(shape_x, shape_y, 0)

  @spec zeros(non_neg_integer, non_neg_integer, non_neg_integer) :: Matrix.t()
  def zeros(shape_x, shape_y, shape_z), do: new(shape_x, shape_y, shape_z, 0)

  # ones
  @spec ones(non_neg_integer) :: Matrix.t()
  def ones(shape_x), do: new(shape_x, 1)

  @spec ones(non_neg_integer, non_neg_integer) :: Matrix.t()
  def ones(shape_x, shape_y), do: new(shape_x, shape_y, 1)

  @spec ones(non_neg_integer, non_neg_integer, non_neg_integer) :: Matrix.t()
  def ones(shape_x, shape_y, shape_z), do: new(shape_x, shape_y, shape_z, 1)
end

defmodule Matrix do
  defstruct data: [], shape: {}

  @spec at(Matrix, integer) :: any
  def at(%Matrix{shape: {shape_x}}, x)
      when x >= shape_x,
      do: raise("Matrix index out of bounds")

  def at(matrix, x), do: Enum.at(matrix.data, x)

  @spec at(Matrix, integer, integer) :: any
  def at(%Matrix{shape: {shape_x, shape_y}}, x, y)
      when x >= shape_x or y >= shape_y,
      do: raise("Matrix index out of bounds")

  def at(matrix, x, y), do: Enum.at(matrix.data, elem(matrix.shape, 1) * y + x)

  def at(%Matrix{shape: {shape_x, shape_y, shape_z}}, x, y, z)
      when x >= shape_x or y >= shape_y or z >= shape_z,
      do: raise("Matrix index out of bounds")

  @spec at(Matrix, integer, integer, integer) :: any
  def at(matrix, x, y, z),
    do:
      Enum.at(
        matrix.data,
        elem(matrix.shape, 1) * elem(matrix.shape, 2) * z + elem(matrix.shape, 2) * y + x
      )
end

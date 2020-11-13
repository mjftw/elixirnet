defmodule Matrex.Coordinates do
  @spec coordinates(Matrex.t()) :: [any]
  def coordinates(matrix) do
    matrix
    |> Enum.with_index()
    |> Enum.map(fn {_, idx} -> {div(idx, matrix[:cols]), rem(idx, matrix[:cols])} end)
  end
end

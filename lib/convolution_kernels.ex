defmodule Convolution.Kernels do
  @moduledoc """
  A collection of common convolution kernels
  """

  @spec sobel_x :: Matrex.t()
  def sobel_x(), do: [
    1, 0, -1,
    2, 0, -2,
    1, 0, -1
  ] |> Matrex.reshape(3, 3)

  @spec sobel_y :: Matrex.t()
  def sobel_y(), do: [
     1,  2,  1,
     0,  0,  0,
    -1, -2, -1
  ] |> Matrex.reshape(3, 3)

  @spec laplace :: Matrex.t()
  def laplace(), do: [
    -1, -1, -1,
    -1,  8, -1,
    -1, -1, -1
  ] |> Matrex.reshape(3, 3)

  @spec sharpen :: Matrex.t()
  def sharpen(), do: [
     0, -1,  0,
    -1,  5, -1,
     0, -1,  0
  ] |> Matrex.reshape(3, 3)

  @spec box_blur :: Matrex.t()
  def box_blur(), do: [
    1/9, 1/9, 1/9,
    1/9, 1/9, 1/9,
    1/9, 1/9, 1/9
  ] |> Matrex.reshape(3, 3)

  @spec gaussian_blur_3 :: Matrex.t()
  def gaussian_blur_3(), do: [
    1/16, 1/8, 1/16,
    1/8,  1/4, 1/8,
    1/16, 1/8, 1/16,
  ] |> Matrex.reshape(3, 3)

  @spec gaussian_blur_5 :: Matrex.t()
  def gaussian_blur_5(), do: [
    1/256,  4/256,  6/256,  4/256, 1/256,
    4/256, 16/256, 24/256, 16/256, 4/256,
    6/256, 24/256, 36/256, 24/256, 6/256,
    4/256, 16/256, 25/256, 16/256, 4/256,
    1/256,  4/256,  6/256,  4/256, 1/256
  ] |> Matrex.reshape(5, 5)

end

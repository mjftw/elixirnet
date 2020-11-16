defmodule Convolution.KernelsTest do
  use ExUnit.Case
  import Convolution.Kernels

  test "sobel_x/0 returns 3x3 Matrex" do
    assert Matrex.size(sobel_x()) == {3, 3}
  end

  test "sobel_y/0 returns 3x3 Matrex" do
    assert Matrex.size(sobel_y()) == {3, 3}
  end

  test "laplace/0 returns 3x3 Matrex" do
    assert Matrex.size(laplace()) == {3, 3}
  end

  test "sharpen/0 returns 3x3 Matrex" do
    assert Matrex.size(sharpen()) == {3, 3}
  end

  test "box_blur/0 returns 3x3 Matrex" do
    assert Matrex.size(box_blur()) == {3, 3}
  end

  test "gaussian_blur_3/0 returns 3x3 Matrex" do
    assert Matrex.size(gaussian_blur_3()) == {3, 3}
  end

  test "gaussian_blur_5/0 returns 5x5 Matrex" do
    assert Matrex.size(gaussian_blur_5()) == {5, 5}
  end
end

defmodule NeuronTest do
  use ExUnit.Case
  doctest Neuron

  test "sums inputs" do
    assert Neuron.run([-10, 1, 23], [1, 1, 1], &(&1)) == 14
  end

  test "multiplies inputs by weights" do
    assert Neuron.run([-10, 1, 23], [0.5, 0, 1], &(&1)) == 18
  end

  test "runs activation function" do
    assert Neuron.run([0, 0, 0], [0, 0, 0], fn(x) -> :test end) == :test
  end
end

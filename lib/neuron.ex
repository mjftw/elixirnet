defmodule Neuron do
  @moduledoc """
  An individual neuron
  """

  @doc """
  Run the neuron an a given input and weights vector, and activation function.
  Ouput is f(sum(In * Wn)) where f is activation function, In is the nth input,
  and Wn is the nth weight.

  No error checking by design to keep executed code as small as possible.
  This code is expected to run A LOT, so speed is key.

  `inputs` vector should be the same length as `weights` vector, and they should
  not be empty.

  ## Examples

      iex> Neuron.run([-0.5, 0.11, 0.75], [0.5, 0, 1], fn(x) -> 0.5*x end)
      0.25

  """
  def run(inputs, weights, activate_fn) do
    Enum.zip(inputs, weights)
    |> Enum.map(fn({i, w}) -> i * w end)
    |> Enum.sum()
    |> activate_fn.()
  end
end

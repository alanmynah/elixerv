defmodule Elixerv do
  @moduledoc """
  Documentation for `Elixerv`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Elixerv.hello()
      :world

  """
  def hello(name) do
    "Hello #{name}"
  end
end

IO.puts Elixerv.hello("Elixir")

defmodule Elixir120 do
  @moduledoc false

  def add_foo_and_bar(data) do
    data.foo + data.bar
  end

  def sum_to_string(a, b) do
    Integer.to_string(a + b)
  end

  def name(map), do: Map.fetch!(map, :name)

  def call do
    # add_foo_and_bar(%{})
    # sum_to_string(1.0, 2.0)

    name(%{})
  end
end

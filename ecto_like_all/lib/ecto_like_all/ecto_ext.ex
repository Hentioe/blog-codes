defmodule EctoLikeAll.EctoExt do
  @moduledoc """
  Ecto extension to add a `like_all` macro to query fields with a list of values.
  """

  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)
      require unquote(__MODULE__)

      import Ecto.Query.API, only: [fragment: 1]
    end
  end

  defmacro like_all(field, list) do
    quote do
      fragment("? LIKE ALL (?)", unquote(field), unquote(list))
    end
  end
end

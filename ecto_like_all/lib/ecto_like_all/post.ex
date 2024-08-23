defmodule EctoLikeAll.Post do
  @moduledoc false

  use Ecto.Schema

  schema "posts" do
    field :title, :string
    field :content, :string

    timestamps()
  end
end

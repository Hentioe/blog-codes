defmodule EctoLikeAll do
  @moduledoc false

  alias EctoLikeAll.{Repo, Post}

  use EctoLikeAll.EctoExt

  import Ecto.Query, only: [from: 2]

  def search_posts(keywords) do
    from(p in Post,
      where: like_all(p.title, ^keywords) or like_all(p.content, ^keywords)
    )
    |> Repo.all()
  end
end

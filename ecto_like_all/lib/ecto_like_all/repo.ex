defmodule EctoLikeAll.Repo do
  use Ecto.Repo,
    otp_app: :ecto_like_all,
    adapter: Ecto.Adapters.Postgres
end

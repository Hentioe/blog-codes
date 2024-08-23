import Config

config :ecto_like_all, :ecto_repos, [EctoLikeAll.Repo]

config :ecto_like_all, EctoLikeAll.Repo,
  database: "ecto_like_all",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  # OR use a URL to connect instead
  url: "postgres://postgres:postgres@localhost/ecto_like_all"

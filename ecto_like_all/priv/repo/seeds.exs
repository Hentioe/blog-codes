# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EctoLikeAll.Repo.insert!(%EctoLikeAll.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

EctoLikeAll.Repo.insert!(%EctoLikeAll.Post{
  title: "Hello world",
  content: "Hello world 的意思是你好世界。"
})

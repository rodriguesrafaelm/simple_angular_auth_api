# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SimpleAuthApi.Repo.insert!(%SimpleAuthApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias SimpleAuthApi.Repo
alias SimpleAuthApi.Contas.{Usuario, Post}
alias SimpleAuthApi.Contas
usuario = Usuario.registration_changeset(%Usuario{}, %{username: "teste", email: "teste@teste", password: "12345678"})
Repo.insert! usuario
Repo.insert! %Post{usuario_id: 1, content: "Apenas um teste da API para verificar a funcionalidade dos posts"}
Repo.insert! %Post{usuario_id: 1, content: "Apenas um outro teste da API para verificar a funcionalidade dos posts"}

usuario2 = Usuario.registration_changeset(%Usuario{}, %{username: "rafael", email: "rafael@email", password: "12345678"})
Repo.insert! usuario2
Repo.insert! %Post{usuario_id: 2, content: "Apenas um teste da API para verificar a funcionalidade dos posts"}
Repo.insert! %Post{usuario_id: 2, content: "Apenas um outro teste da API para verificar a funcionalidade dos posts"}

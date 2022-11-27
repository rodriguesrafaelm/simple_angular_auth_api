defmodule SimpleAuthApiWeb.UsuarioController do
  use SimpleAuthApiWeb, :controller

  alias SimpleAuthApi.Contas
  alias SimpleAuthApi.Contas.Usuario



  action_fallback SimpleAuthApiWeb.FallbackController

  def index(conn, _params) do
    usuarios = Contas.list_usuarios()
    render(conn, "index.json", usuarios: usuarios)
  end



  def register(conn, %{"user" => user_params}) do
    with {:ok, %Usuario{} = user} <- Contas.add_user(user_params) do
      conn
      |> put_status(:created)
      |> text("Usuário cadastrado com sucesso, usando o email:" <> " " <> user.email)

    end
  end


  def verificar_disponinibilidade(conn, %{"username" => username}) do
    IO.inspect(username)
    body = Contas.verify_username_availability(username)

    conn
    |> put_status(200)
    |> json(body)
  end


end

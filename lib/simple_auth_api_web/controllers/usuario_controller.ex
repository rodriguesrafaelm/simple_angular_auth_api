defmodule SimpleAuthApiWeb.UsuarioController do
  use SimpleAuthApiWeb, :controller

  alias SimpleAuthApi.Contas



  action_fallback SimpleAuthApiWeb.FallbackController

  def index(conn, _params) do
    usuarios = Contas.list_usuarios()
    render(conn, "index.json", usuarios: usuarios)
  end

  def verificar_disponibilidade(conn, %{"username" => username}) do
    body = Contas.verify_username_availability(username)
    conn
    |> put_status(200)
    |> json(body)
  end

  def listar_posts(conn, %{"id" => id}) do
    body = Contas.get_user_posts(id)
    conn
    |> send_resp(200, body)
  end

  def listar_posts_username(conn, %{"username" => username}) do
    body = Contas.get_user_posts_username(username)
    conn
    |> send_resp(200, body)
  end

  def publicar_post(conn, post_data) do
    user = SimpleAuthApi.Authentication.Guardian.get_user(conn)
    Contas.publish_user_post(user, post_data)
    conn
    |> send_resp(200, Jason.encode!(%{status: "sucesso"}))
  end
end



 # def register(conn, %{"user" => user_params}) do
  #   with {:ok, %Usuario{} = user} <- Contas.add_user(user_params) do
  #     conn
  #     |> put_status(:created)
  #     |> text("Usuário cadastrado com sucesso, usando o email:" <> " " <> user.email)

  #   end
  # end

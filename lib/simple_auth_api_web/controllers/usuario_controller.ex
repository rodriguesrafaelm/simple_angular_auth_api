defmodule SimpleAuthApiWeb.UsuarioController do
  use SimpleAuthApiWeb, :controller

  alias SimpleAuthApi.Contas
  alias SimpleAuthApi.Contas.Usuario

  action_fallback SimpleAuthApiWeb.FallbackController

  def index(conn, _params) do
    usuarios = Contas.list_usuarios()
    render(conn, "index.json", usuarios: usuarios)
  end

  def create(conn, %{"usuario" => usuario_params}) do
    with {:ok, %Usuario{} = usuario} <- Contas.create_usuario(usuario_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.usuario_path(conn, :show, usuario))
      |> render("show.json", usuario: usuario)
    end
  end

  def show(conn, %{"id" => id}) do
    usuario = Contas.get_usuario!(id)
    render(conn, "show.json", usuario: usuario)
  end

  def update(conn, %{"id" => id, "usuario" => usuario_params}) do
    usuario = Contas.get_usuario!(id)

    with {:ok, %Usuario{} = usuario} <- Contas.update_usuario(usuario, usuario_params) do
      render(conn, "show.json", usuario: usuario)
    end
  end

  def delete(conn, %{"id" => id}) do
    usuario = Contas.get_usuario!(id)

    with {:ok, %Usuario{}} <- Contas.delete_usuario(usuario) do
      send_resp(conn, :no_content, "")
    end
  end





  def register(conn, %{"user" => user_params}) do
    with {:ok, %Usuario{} = user} <- Contas.add_user(user_params) do
      conn
      |> put_status(:created)
      |> text("Usuário cadastrado com sucesso, usando o email:" <> " " <> user.email)

    end
  end

end

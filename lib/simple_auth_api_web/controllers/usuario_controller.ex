defmodule SimpleAuthApiWeb.UsuarioController do
  use SimpleAuthApiWeb, :controller

  alias SimpleAuthApi.Contas
  alias SimpleAuthApi.Contas.Usuario
  alias SimpleAuthApi.Authentication.Guardian


  action_fallback SimpleAuthApiWeb.FallbackController

  def index(conn, _params) do
    usuarios = Contas.list_usuarios()
    render(conn, "index.json", usuarios: usuarios)
  end

  def create(conn, usuario_params) do
    with {:ok, %Usuario{} = usuario} <- Contas.add_user(usuario_params) do
      conn
      |> autorize(usuario)
      |> send_resp(200, '')
    end
  end

  defp autorize(conn, usuario) do

    {:ok, access_token, _claims} = Guardian.encode_and_sign(usuario, %{}, token_type: "access", ttl: {1, :hour})

    conn
    |> put_resp_header("Access-Control-Expose-Headers", "x-access-token")
    |> put_resp_header("x-access-token", access_token)
    |> put_status(:created)
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

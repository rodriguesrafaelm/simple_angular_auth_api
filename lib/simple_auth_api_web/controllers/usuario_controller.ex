defmodule SimpleAuthApiWeb.UsuarioController do
  use SimpleAuthApiWeb, :controller

  alias SimpleAuthApi.Contas



  action_fallback SimpleAuthApiWeb.FallbackController

  def index(conn, _params) do
    usuarios = Contas.list_usuarios()
    render(conn, "index.json", usuarios: usuarios)
  end




  def verificar_disponibilidade(conn, %{"username" => username}) do
    IO.inspect(username)
    body = Contas.verify_username_availability(username)
    IO.inspect(body)
    conn
    |> put_status(200)
    |> json(body)
  end


  def get_posts(conn, %{"id" => id}) do
    body = %{nome: "rafael", idade: "22"}
    IO.inspect(conn)
    conn
    |> put_status(200)
    |> json(body)
  end

end



 # def register(conn, %{"user" => user_params}) do
  #   with {:ok, %Usuario{} = user} <- Contas.add_user(user_params) do
  #     conn
  #     |> put_status(:created)
  #     |> text("Usuário cadastrado com sucesso, usando o email:" <> " " <> user.email)

  #   end
  # end

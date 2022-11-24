defmodule SimpleAuthApiWeb.SessionController do
  use SimpleAuthApiWeb, :controller

  alias SimpleAuthApi.Contas
  alias SimpleAuthApi.Authentication.Guardian

  action_fallback SimpleAuthApiWeb.FallbackController

  def new(conn, %{"username" => username, "password" => password}) do
    case Contas.authenticate_user(username, password) do
      {:ok, user} ->
        {:ok, access_token, _claims} =
          Guardian.encode_and_sign(user, %{}, token_type: "access", ttl: {1, :hour})
        conn
        |> put_resp_header("Access-Control-Expose-Headers", "x-access-token")
        |> put_resp_header("x-access-token", access_token)
        |> put_status(:created)
        |> send_resp(200, '')
        |> IO.inspect()

      {:error, message} ->
        body = Jason.encode!(%{error: message})
        conn
          |> send_resp(401, body)


    end
  end





end

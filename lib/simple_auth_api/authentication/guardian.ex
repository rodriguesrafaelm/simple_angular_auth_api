defmodule SimpleAuthApi.Authentication.Guardian do
  use Guardian, otp_app: :simple_auth_api
  alias SimpleAuthApi.Contas

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = Contas.get_usuario!(id)
    {:ok, resource}
  end

  def get_user(conn) do
    claims = SimpleAuthApi.Authentication.Guardian.Plug.current_claims(conn)
    claims["sub"]
  end

end

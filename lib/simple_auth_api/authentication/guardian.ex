defmodule SimpleAuthApi.Authentication.Guardian do
  use Guardian, otp_app: :simple_auth_api
  alias SimpleAuthApi.Contas

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.username)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = Contas.get_usuario!(id)
    {:ok, resource}
  end

end

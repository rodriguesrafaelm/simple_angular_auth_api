defmodule SimpleAuthApi.Authentication.Guardian.AuthPipeline do
  @claims %{typ: "access"}


  use Guardian.Plug.Pipeline,
    otp_app: :auth_api,
    module: SimpleAuthApi.Authentication.Guardian,
    error_handler: SimpleAuthApi.Authentication.Guardian.ErrorHandler


  plug(Guardian.Plug.VerifyHeader, claims: @claims, realm: :none, header_name: "x-access-token")
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource, ensure: true)




end

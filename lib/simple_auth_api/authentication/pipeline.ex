defmodule SimpleAuthApi.Authentication.Guardian.AuthPipeline do
  @claims %{typ: "access"}


  use Guardian.Plug.Pipeline,
    otp_app: :auth_api,
    module: AuthApi.Guardian,
    error_handler: AuthApi.Guardian.AuthErrorHandler


  plug(Guardian.Plug.VerifyHeader, claims: @claims, scheme: "Bearer")
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource, ensure: true)




end

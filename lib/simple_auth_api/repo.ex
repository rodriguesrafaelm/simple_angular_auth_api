defmodule SimpleAuthApi.Repo do
  use Ecto.Repo,
    otp_app: :simple_auth_api,
    adapter: Ecto.Adapters.Postgres
end

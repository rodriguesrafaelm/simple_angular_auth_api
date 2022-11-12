import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :simple_auth_api, SimpleAuthApi.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "simple_auth_api_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :simple_auth_api, SimpleAuthApiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Q0iYAP6rRasNUDKNkiowGDESSPVsI6oomI0z7BofmO7jgnwIPf/PzicVcVz75fET",
  server: false

# In test we don't send emails.
config :simple_auth_api, SimpleAuthApi.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

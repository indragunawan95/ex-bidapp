import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :exbidapp, Exbidapp.Repo,
  username: System.get_env("EX_BID_APP_DB_USERNAME_TEST", "postgres"),
  password: System.get_env("EX_BID_APP_DB_PASSWORD_TEST", "postgres"),
  hostname: System.get_env("EX_BID_APP_DB_HOST_TEST", "localhost"),
  database:
    System.get_env("EX_BID_APP_DB_DBNAME_TEST", "exbidapp_test") <>
      System.get_env("MIX_TEST_PARTITION", ""),
  port: System.get_env("EX_BID_APP_DB_PORT_TEST", "5432"),
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :exbidapp, ExbidappWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "K4FkzykhBLSAXRgsOvRDHUus24wIq905/aWKeGsj/91pvlNsN6ehQ+c+l3LPr2xF",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

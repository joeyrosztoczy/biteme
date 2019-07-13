use Mix.Config

# Configure your database
config :biteme, Biteme.Repo,
  username: "postgres",
  password: "postgres",
  database: "biteme_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :biteme, BitemeWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

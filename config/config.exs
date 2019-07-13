# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :biteme,
  ecto_repos: [Biteme.Repo]

# Configures the endpoint
config :biteme, BitemeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gQ44RdFIdaDO5Ed1QLGjLwN0JJvFouMRb7N6r6+QS5vJ4UkFBip9CFtZIcQzONL5",
  render_errors: [view: BitemeWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Biteme.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

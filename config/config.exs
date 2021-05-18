# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config( :nya,
  ecto_repos: [Nya.Repo] )

# Configures the endpoint
config( :nya, NyaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "s8ciYg9FfbQ/9LIa5uPWAhxCx2mY1JqQIt225viLTIQNGdTKY/lHzHU9jmSb71Ef",
  render_errors: [view: NyaWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Nya.PubSub,
  live_view: [signing_salt: "nNDZ+BWX"] )

# Configure Guardian
config( :nya, NyaWeb.Guardian,
  issuer: "nya",
  secret_key: 
    System.get_env("GUARDIAN_SECRET_KEY") 
    || "dupa-Super_SECRET$$KeyeYErYEeE" )

# Configures Elixir's Logger
config( :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id] )

# Use Jason for JSON parsing in Phoenix
config( :phoenix, :json_library, Jason )

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config("#{Mix.env()}.exs")

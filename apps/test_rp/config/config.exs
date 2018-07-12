# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :test_rp,
  namespace: TestRp

# Configures the endpoint
config :test_rp, TestRpWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vN9rXEwxbI/KxZIcN+oQ8ZGBFBo2289BTCSseY7CvZUTDQT+yOx/cgiAYAH5MSiS",
  render_errors: [view: TestRpWeb.ErrorView, accepts: ~w(json)]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

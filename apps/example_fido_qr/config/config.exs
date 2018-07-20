# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :example_fido_qr,
  namespace: ExampleFidoQR

# Configures the endpoint
config :example_fido_qr, ExampleFidoQRWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vN9rXEwxbI/KxZIcN+oQ8ZGBFBo2289BTCSseY7CvZUTDQT+yOx/cgiAYAH5MSiS",
  render_errors: [view: ExampleFidoQRWeb.ErrorView, accepts: ~w(json)]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Configures FidoQrCode library
config :fido_qr_code,
  fido_server_client: FidoQrCode.FidoServer.Client,
  relying_party_url: "http://relying-party.example.com",
  callback_url: "http://relying-party.example.com/callback",
  fido_server_url: "http://localhost:4001",
  requested_scopes: ~w(email phone),
  scope_request_ttl: 1_000,
  ecto_repos: [FidoQrCode.Repo]

# Configures FidoQrCode Repo
config :fido_qr_code, FidoQrCode.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "fido_qr_code",
  hostname: "localhost"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

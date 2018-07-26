use Mix.Config

config :exuaf,
  namespace: ExUAF,
  ecto_repos: [ExUAF.Repo],
  generators: [binary_id: true]

config :exuaf, fido_client: ExUAF.FidoServer.Client

config :exuaf, ExUAFWeb.Endpoint,
  load_from_system_env: true,
  url: [host: "localhost"],
  secret_key_base: "fsUwr9HzZhrg9VIu30TB5DaWD2gsWft2rSoR8XchaKctNWHCcw9KjEERXq2dxHrE",
  render_errors: [view: ExUAFWeb.ErrorView, accepts: ~w(json)]

config :phoenix, :format_encoders, json: Jason

# Configures Elixir's Logger
config :logger, :console,
  format: "$message\n",
  handle_otp_reports: true,
  level: :info

config :exuaf, ExUAF.FidoServer.Client, url: "http://localhost:8080"

config :exuaf, ExUAF.Facets,
  ids: {:system, :list, "FACET_TRUSTED_IDS"},
  version: [
    major: {:system, :integer, "FACET_VERSION_MAJOR", 1},
    minor: {:system, :integer, "FACET_VERSION_MAJOR", 0}
  ]

import_config "#{Mix.env()}.exs"

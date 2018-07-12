use Mix.Config

config :exuaf,
  namespace: EXUAF,
  ecto_repos: [EXUAF.Repo],
  generators: [binary_id: true]

config :exuaf, EXUAFWeb.Endpoint,
  load_from_system_env: true,
  url: [host: "localhost"],
  secret_key_base: "fsUwr9HzZhrg9VIu30TB5DaWD2gsWft2rSoR8XchaKctNWHCcw9KjEERXq2dxHrE",
  render_errors: [view: EXUAFWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: EXUAF.PubSub, adapter: Phoenix.PubSub.PG2]

config :phoenix, :format_encoders, json: Jason

# Configures Elixir's Logger
config :logger, :console,
  format: "$message\n",
  handle_otp_reports: true,
  level: :info

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

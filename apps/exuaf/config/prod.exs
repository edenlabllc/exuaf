use Mix.Config

config :exuaf, ExUAFWeb.Endpoint,
  load_from_system_env: true,
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

# Do not print debug messages in production
config :logger, level: :info

config ExUAF.FidoServer.Client, url: "${FIDO_SERVER_URL}"

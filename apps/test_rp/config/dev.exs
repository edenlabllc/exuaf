use Mix.Config

config :test_rp, TestRpWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

config :logger, :console, format: "[$level] $message\n"

config :fido_qr_code, FidoQrCode.Repo,
       adapter: Ecto.Adapters.Postgres,
       database: "fido_qr_code_dev",
       hostname: "localhost"


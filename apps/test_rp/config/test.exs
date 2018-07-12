use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :test_rp, TestRpWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :fido_qr_code,
       fido_server_client: FidoServerClientMock,
       fido_server_url: "http://localhost:8080",
       callback_url: "http://localhost:4001/callback",
       requested_scopes: ["documents.driver_license"],
       scope_request_ttl: 1000

config :fido_qr_code, FidoQrCode.Repo,
       adapter: Ecto.Adapters.Postgres,
       database: "fido_qr_code_test",
       hostname: "localhost"
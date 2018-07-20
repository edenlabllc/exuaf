# ExampleFidoQR

Configure FidoQrCode library
```elixir
# config.exs

config :fido_qr_code,
  fido_server_client: FidoQrCode.FidoServer.Client,
  callback_url: "http://relying-party.example.com/callback",
  fido_server_url: "http://localhost:4001",
  requested_scopes: ~w(email phone),
  scope_request_ttl: 1_000,
  ecto_repos: [FidoQrCode.Repo]

config :fido_qr_code, FidoQrCode.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "fido_qr_code_test",
  hostname: "localhost"
```

Run migrations for FidoQrCode library
```bash
mix ecto.migrate -r FidoQrCode.Repo
```

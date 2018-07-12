defmodule TestRpWeb.Router do
  use TestRpWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TestRpWeb do
    pipe_through :api

    post("/qr-code", QrCodeController, :create)
  end
end

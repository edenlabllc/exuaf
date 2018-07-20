defmodule ExampleFidoQRWeb.Router do
  use ExampleFidoQRWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", ExampleFidoQRWeb do
    pipe_through(:api)

    get("/qr-code", ExampleController, :create)

    get("/callback", ExampleController, :callback)
  end
end

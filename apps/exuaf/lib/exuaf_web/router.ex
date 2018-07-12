defmodule EXUAFWeb.Router do
  use EXUAFWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/v1/public", EXUAFWeb do
    pipe_through(:api)

    get("/regRequest/:username", RegistrationController, :create)
  end
end

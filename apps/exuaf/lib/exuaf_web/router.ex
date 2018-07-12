defmodule EXUAFWeb.Router do
  use EXUAFWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/v1/public", EXUAFWeb do
    pipe_through(:api)

    get("/regRequest/:username", FidoController, :reg_request)
    post("/regResponse", FidoController, :reg_response)

    post("/uafAuthRequest", FidoController, :auth_request)
    post("/uafAuthResponse", FidoController, :auth_response)

    # Elixir implementation
    head("/regRequest/:username/:app_id", RegistrationController, :is_registered)
    head("/registration/:username/:app_id", RegistrationController, :is_registered)

#    post("/registration/request/:username", RegistrationController, :create)
#    post("/registration/response", RegistrationController, :create_request)

#    post("/auth/request", AuthenticationController, :create_request)
#    post("/auth/response", AuthenticationController, :create_request)
  end
end

defmodule ExUAFWeb.Router do
  use ExUAFWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/v1/public", ExUAFWeb do
    pipe_through(:api)

    get("/uaf/facets", FidoController, :facets)

    # Registration
    get("/regRequest/:username", FidoController, :reg_request)
    post("/regResponse", FidoController, :reg_response)

    # Authentications
    post("/uafAuthRequest", FidoController, :auth_request)
    post("/uafAuthResponse", FidoController, :auth_response)

    # Elixir implementation
    get("/registrations/:username", RegistrationController, :is_registered)
    head("/registrations/:username", RegistrationController, :is_registered)

    #    post("/registration/request/:username", RegistrationController, :create)
    #    post("/registration/response", RegistrationController, :create_request)

    #    post("/auth/request", AuthenticationController, :create_request)
    #    post("/auth/response", AuthenticationController, :create_request)
  end
end

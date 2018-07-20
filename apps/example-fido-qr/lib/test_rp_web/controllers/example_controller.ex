defmodule ExampleFidoQRWeb.ExampleController do
  use ExampleFidoQRWeb, :controller

  def create(conn, params) do
    {:ok, scope_request} = FidoQrCode.create_scope_request()

    conn
    |> put_resp_content_type("image/png")
    |> send_resp(201, FidoQrCode.generate_qr_code(scope_request))
  end

  # validate request for required param scope_request
  def callback(conn, %{"scope_request" => id}) do
    username = "get-from-headers"
    with {:ok, %{scope_request: _, fido: _} = resp} <- FidoQrCode.process_scope_request(id, username) do
      json(conn, resp)
    else
      {:error, :scope_request_already_processed}
      -> json(conn, %{error: "Scope request already processed"})

      {:error, :scope_request_expired}
      -> json(conn, %{error: "Scope request expired"})
    end
  end
end

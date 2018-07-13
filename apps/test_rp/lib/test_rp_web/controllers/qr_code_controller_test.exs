defmodule ExUAF.QrCodeController do
  use ExUAFWeb, :controller

  def create(conn, params) do
    conn
    |> put_resp_content_type("image/png")
    |> send_resp(201, FidoQrCode.generate_qr_code(params["scope_request"]))
  end
end

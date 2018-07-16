defmodule ExUAFWeb.FidoController do
  @moduledoc """
  Proxy controller to Java FIDO UAF sever
  """

  use ExUAFWeb, :controller

  alias ExUAF.FallbackController

  action_fallback(FallbackController)

  @fido_client Application.get_env(:exuaf, :fido_client)

  def facets(conn, _params) do
    with {:ok, resp} <- @fido_client.facets() |> IO.inspect() do
      json(conn, resp)
    end
  end

  def reg_request(conn, params) do
    with {:ok, resp} <- @fido_client.reg_request(params["username"]) do
      json(conn, resp)
    end
  end

  def reg_response(conn, %{"_json" => json}), do: reg_response(conn, json)

  def reg_response(conn, params) do
    with {:ok, resp} <- @fido_client.reg_response(params) do
      json(conn, resp)
    end
  end

  def auth_request(conn, _params) do
    with {:ok, resp} <- @fido_client.auth_request do
      json(conn, resp)
    end
  end

  def auth_response(conn, %{"_json" => json}), do: auth_response(conn, json)

  def auth_response(conn, params) do
    with {:ok, resp} <- @fido_client.auth_response(params) do
      json(conn, resp)
    end
  end
end

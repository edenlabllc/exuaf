defmodule ExUAF.FidoServer.Client do
  use HTTPoison.Base
  alias ExUAF.FidoServer.ClientBehaviour

  @behaviour ClientBehaviour

  @spec process_url(binary) :: binary
  def process_url(url), do: Confex.fetch_env!(:exuaf, __MODULE__)[:url] <> url

  @filter_headers ["content-length", "Content-Length"]

  def process_request_headers(headers) do
    headers
    |> Keyword.drop(@filter_headers)
    |> Kernel.++([{"Content-Type", "application/json"}])
  end

  @spec facets :: {:ok, map} | {:error, tuple}
  def facets do
    get!("/v1/public/uaf/facets")
  end

  @spec create_request(binary) :: {:ok, map} | {:error, tuple}
  def create_request(username) do
    # ToDo decide which request create by stored puyblic key in Fido Server
    reg_request(username)
  end

  @spec reg_request(binary) :: {:ok, map} | {:error, tuple}
  def reg_request(username) do
    get!("/v1/public/regRequest/#{username}")
  end

  @spec reg_response(term) :: {:ok, map} | {:error, tuple}
  def reg_response(data) do
    post!("/v1/public/regResponse", Jason.encode!(data))
  end

  @spec auth_request :: {:ok, map} | {:error, tuple}
  def auth_request do
    get!("/v1/public/authRequest")
  end

  @spec auth_response(term) :: {:ok, map} | {:error, tuple}
  def auth_response(data) do
    post!("/v1/public/uafAuthResponse", Jason.encode!(data))
  end

  @spec request!(binary, binary, binary, list, list) :: {:ok, map} | {:error, tuple}
  def request!(method, url, body \\ "", headers \\ [], options \\ []) do
    method
    |> super(url, body, headers, options)
    |> ResponseDecoder.check_response()
  end
end

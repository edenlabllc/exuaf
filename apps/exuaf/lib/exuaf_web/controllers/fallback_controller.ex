defmodule ExUAF.FallbackController do
  @moduledoc """
  This controller should be used as `action_fallback` in rest of controllers to remove duplicated error handling.
  """

  use ExUAFWeb, :controller

  alias ExUAFWeb.ErrorView

  @typep fallback_param_t :: nil | tuple | Ecto.Changeset.t()

  @spec call(Plug.Conn.t(), fallback_param_t) :: Plug.Conn.t()
  def call(conn, nil), do: call(conn, {:error, :not_found})

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(ErrorView, :"404")
  end

  def call(conn, {:error, {:unprocessable_entity, error}}) do
    conn
    |> put_status(422)
    |> render(ErrorView, :"422", %{message: error})
  end

  def call(conn, %Ecto.Changeset{valid?: false} = changeset), do: call(conn, {:error, changeset})

  def call(conn, {:error, %Ecto.Changeset{valid?: false} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(ValidationError, :"422", changeset)
  end

  def call(conn, {:error, {:internal_error, message}}) do
    conn
    |> put_status(:internal_server_error)
    |> render(ErrorView, :"500", %{message: message})
  end

  def call(conn, {:error, {:response_json_decoder, output}}) do
    conn
    |> put_status(:internal_server_error)
    |> render(ErrorView, :"500", %{message: "invalid JSON from FIDO Server"})
  end

  def call(conn, {:error, {:getaway_timeout, message}}) do
    conn
    |> put_status(504)
    |> render(ErrorView, :"500", %{message: message})
  end

  def call(conn, _), do: call(conn, {:error, :not_found})
end

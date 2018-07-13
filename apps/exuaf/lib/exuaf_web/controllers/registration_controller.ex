defmodule ExUAFWeb.RegistrationController do
  use ExUAFWeb, :controller

  alias ExUAF.FallbackController
  alias EXUAF.Registrations
  alias EXUAF.Registrations.Registration

  action_fallback(FallbackController)

  def is_registered(conn, %{"username" => username}) do
    case Registrations.get_by(username: username) do
      %Registration{} -> send_resp(conn, 204, "")
      _ -> send_resp(conn, 404, "")
    end
  end

  def create(conn, params) do
    conn
    |> put_status(200)
    |> json(%{
      "header" => %{
        "upv" => %{
          major: 1,
          minor: 0
        },
        "op" => "Reg",
        "appID" => "http://localhost:8080/v1/public/exuaf/facets",
        "serverData" => server_data()
      },
      "challenge" => challenge(),
      "username" => params["username"],
      "policy" => policy()
    })
  end

  defp server_data do
    %{}
  end

  defp challenge do
    "asd"
  end

  defp policy do
    %{
      "accepted" => ""
    }
  end

  defp accepted_aaids do
    [
      "EBA0#0001",
      "0015#0001",
      "0012#0002",
      "0010#0001",
      "4e4e#0001",
      "5143#0001",
      "0011#0701",
      "0013#0001",
      "0014#0000",
      "0014#0001",
      "53EC#C002",
      "DAB8#8001",
      "DAB8#0011",
      "DAB8#8011",
      "5143#0111",
      "5143#0120",
      "4746#F816",
      "53EC#3801"
    ]
  end
end

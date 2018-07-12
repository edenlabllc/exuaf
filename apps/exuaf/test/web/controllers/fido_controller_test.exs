defmodule ExUAF.Web.FidoControllerTest do
  @moduledoc false

  use EXUAFWeb.ConnCase, async: false

  @fcParams "eyJhcHBJRCI6Imh0dHBzOi8vdWFmLXRlc3QtMS5ub2tub2t0ZXN0LmNvbTo4NDQzL1NhbXBsZUFwcC91YWYvZmFjZXRzIiwiY2hhbGxlbmdlIjoiSDlpVzl5QTlhQVhGX2xlbFFvaV9EaFVrNTE0QWQ4VHF2MHpDbkNxS0RwbyIsImNoYW5uZWxCaW5kaW5nIjp7fSwiZmFjZXRJRCI6ImNvbS5ub2tub2suYW5kcm9pZC5zYW1wbGVhcHAifQ"

  @assertion_schema "UAFV1TLV"
  @assertion "AT7uAgM-sQALLgkAQUJDRCNBQkNEDi4HAAABAQEAAAEKLiAA9tBzZC64ecgVQBGSQb5QtEIPC8-Vav4HsHLZDflLaugJLiAAZMCPn92yHv1Ip-iCiBb6i4ADq6ZOv569KFQCvYSJfNgNLggAAQAAAAEAAAAMLkEABJsvEtUsVKh7tmYHhJ2FBm3kHU-OCdWiUYVijgYa81MfkjQ1z6UiHbKP9_nRzIN9anprHqDGcR6q7O20q_yctZAHPjUCBi5AACv8L7YlRMx10gPnszGO6rLFqZFmmRkhtV0TIWuWqYxd1jO0wxam7i5qdEa19u4sfpHFZ9RGI_WHxINkH8FfvAwFLu0BMIIB6TCCAY8CAQEwCQYHKoZIzj0EATB7MQswCQYDVQQGEwJVUzELMAkGA1UECAwCQ0ExCzAJBgNVBAcMAlBBMRAwDgYDVQQKDAdOTkwsSW5jMQ0wCwYDVQQLDAREQU4xMRMwEQYDVQQDDApOTkwsSW5jIENBMRwwGgYJKoZIhvcNAQkBFg1ubmxAZ21haWwuY29tMB4XDTE0MDgyODIxMzU0MFoXDTE3MDUyNDIxMzU0MFowgYYxCzAJBgNVBAYTAlVTMQswCQYDVQQIDAJDQTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzEQMA4GA1UECgwHTk5MLEluYzENMAsGA1UECwwEREFOMTETMBEGA1UEAwwKTk5MLEluYyBDQTEcMBoGCSqGSIb3DQEJARYNbm5sQGdtYWlsLmNvbTBZMBMGByqGSM49AgEGCCqGSM49AwEHA0IABCGBt3CIjnDowzSiF68C2aErYXnDUsWXOYxqIPim0OWg9FFdUYCa6AgKjn1R99Ek2d803sGKROivnavmdVH-SnEwCQYHKoZIzj0EAQNJADBGAiEAzAQujXnSS9AIAh6lGz6ydypLVTsTnBzqGJ4ypIqy_qUCIQCFsuOEGcRV-o4GHPBph_VMrG3NpYh2GKPjsAim_cSNmQ"

  describe "registration request" do
    test "success", %{conn: conn} do
      # create regRequest
      resp =
        conn
        |> get(fido_path(conn, :reg_request, "test-#{:rand.uniform(10_000)}"))
        |> json_response(200)

      assert is_list(resp)

      Enum.each(resp, fn elem ->
        assert is_map(elem)

        Enum.each(~w(header policy username challenge), fn key ->
          assert Map.has_key?(elem, key), "regRequest response should contain field `#{key}`}"
        end)
      end)

      header = hd(resp)["header"]

      # send regResponse
      data = [
        %{
          header: header,
          fcParams: @fcParams,
          assertions: [
            %{
              assertion: @assertion,
              assertionScheme: @assertion_schema
            }
          ]
        }
      ]

      resp =
        conn
        |> put_req_header("content-type", "application/json")
        |> post(fido_path(conn, :reg_response), Jason.encode!(data))
        |> json_response(200)

      assert is_list(resp)

      Enum.each(resp, fn elem ->
        assert is_map(elem)

        Enum.each(
          ~w(authenticator authenticator_id PublicKey attestCert attestDataToSign attestSignature attestVerifiedStatus),
          fn key ->
            assert Map.has_key?(elem, key), "regResponse response should contain field `#{key}`}"
          end
        )

        assert is_map(elem["authenticator"])
      end)
    end
  end

  describe "auth request" do
    @tag :pending
    test "success", %{conn: conn} do
      # create authRequest
      resp =
        conn
        |> post(fido_path(conn, :auth_request))
        |> json_response(200)

      assert is_map(resp)

      Enum.each(resp, fn elem ->
        assert is_map(elem)

        Enum.each(~w(header policy username challenge), fn key ->
          assert Map.has_key?(elem, key), "regRequest response should contain field `#{key}`}"
        end)
      end)

      header = hd(resp)["header"]

      # send authResponse
      data = [
        %{
          header: header,
          fcParams: @fcParams,
          assertions: [
            %{
              assertion: @assertion,
              assertionScheme: @assertion_schema
            }
          ]
        }
      ]

      resp =
        conn
        |> put_req_header("content-type", "application/json")
        |> post(fido_path(conn, :auth_response), Jason.encode!(data))
        |> json_response(200)

      assert is_list(resp)

      Enum.each(resp, fn elem ->
        assert is_map(elem)

        Enum.each(
          ~w(authenticator authenticator_id PublicKey attestCert attestDataToSign attestSignature attestVerifiedStatus),
          fn key ->
            assert Map.has_key?(elem, key), "regResponse response should contain field `#{key}`}"
          end
        )

        assert is_map(elem["authenticator"])
      end)
    end
  end

  describe "check is user registered" do
  end
end

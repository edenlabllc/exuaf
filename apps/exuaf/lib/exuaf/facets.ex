defmodule ExUAF.Facets do
  def get_trusted do
    %{
      trustedFacets: [
        %{
          version: version(),
          ids: Confex.fetch_env!(:exuaf, __MODULE__)[:ids]
        }
      ]
    }
  end

  defp version do
    version = Confex.fetch_env!(:exuaf, __MODULE__)[:version]

    %{
      major: version[:major],
      minor: version[:minor]
    }
  end
end

defmodule EXUAF.Registrations do
  import Ecto.Query, only: [select: 3, where: 3, limit: 2]

  alias EXUAF.Registrations.Registration
  alias ExUAF.Repo

  @spec get!(binary) :: Registration.t()
  def get!(id), do: Repo.get!(Registration, id)

  def get_by(params), do: Repo.get_by(Registration, params)

  def username_registered?(username) do
    Registration
    |> select([r], r.username)
    |> where([r], r.username == ^username)
    |> limit(1)
    |> Repo.all()
    |> case do
      [] -> false
      [_] -> true
    end
  end
end

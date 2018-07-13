defmodule EXUAF.Registrations do
  alias ExUAF.Repo

  alias EXUAF.Registrations.Registration

  @spec get!(binary) :: Registration.t()
  def get!(id), do: Repo.get!(Registration, id)

  def get_by(params), do: Repo.get_by(Registration, params)
end
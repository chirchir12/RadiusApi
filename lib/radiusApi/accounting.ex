defmodule RadiusApi.Accounting do
  alias RadiusApi.Repo
  alias RadiusApi.Accounting.Radacct

  def get!(id), do: Repo.get!(Radacct, id)
end

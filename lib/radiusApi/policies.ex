defmodule RadiusApi.Policies do
  alias RadiusApi.Repo
  alias RadiusApi.Policies.Radgroupcheck
  alias RadiusApi.Policies.Radgroupreply

  def create_group_check!(attrs) do
    %Radgroupcheck{}
    |> Radgroupcheck.changeset(attrs)
    |> Repo.insert!()
  end

  def create_group_reply!(attrs) do
    %Radgroupreply{}
    |> Radgroupreply.changeset(attrs)
    |> Repo.insert!()
  end
end

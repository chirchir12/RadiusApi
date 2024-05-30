defmodule RadiusApi.Policies do
  import Ecto.Query
  alias RadiusApi.Repo
  alias RadiusApi.Policies.Radgroupcheck
  alias RadiusApi.Policies.Radgroupreply
  alias RadiusApi.Policies.Radcheck
  alias RadiusApi.Policies.Radusergroup

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

  def check_if_exists!(group_name) do
    query = from p in Radgroupcheck, where: p.group_name == ^group_name

    case Repo.exists?(query) do
      true -> {:ok, true}
      false -> {:error, "group_name_not_found"}
    end
  end

  def add_radcheck(multi, attrs) do
    changeset =
      %Radcheck{}
      |> Radcheck.changeset(attrs)

    Ecto.Multi.insert(multi, "insert_radcheck", changeset)
  end

  def add_radusergroup(multi, attrs) do
    changeset =
      %Radusergroup{}
      |> Radusergroup.changeset(attrs)

    Ecto.Multi.insert(multi, "insert_usergroup", changeset)
  end
end

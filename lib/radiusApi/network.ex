defmodule RadiusApi.Network do
  alias RadiusApi.Users
  alias RadiusApi.Policies
  alias RadiusApi.Policies.Radcheck
  alias RadiusApi.Policies.Radusergroup
  alias RadiusApi.Repo

  def add_user_to_network(%{"email" => email, "type" => type}) do
    with {:ok, user} <- Users.get_by_email(email),
         {:ok, _} <- Policies.check_if_exists!(type) do
      Ecto.Multi.new()
      |> add_radcheck(%{
        username: user.email,
        attribute: "Cleartext-Password",
        op: ":=",
        value: user.password
      })
      |> add_radusergroup(%{
        username: user.email,
        groupname: type,
        priority: 3
      })
      |> Repo.transaction()
    end
  end

  def remove_user_from_network(email) do
    email = email |> String.downcase()

    with {:ok, _} <- Users.get_by_email(email),
         radcheck <- exists_in_radcheck!(email),
         radusergroup <- exists_in_radusergroup!(email) do
      Ecto.Multi.new()
      |> Ecto.Multi.delete(:delete_radcheck, radcheck)
      |> Ecto.Multi.delete(:delete_radusergroup, radusergroup)
      |> Repo.transaction()
    end
  end

  defp add_radcheck(multi, attrs) do
    changeset =
      %Radcheck{}
      |> Radcheck.changeset(attrs)

    Ecto.Multi.insert(multi, "insert_radcheck", changeset)
  end

  defp add_radusergroup(multi, attrs) do
    changeset =
      %Radusergroup{}
      |> Radusergroup.changeset(attrs)

    Ecto.Multi.insert(multi, "insert_usergroup", changeset)
  end

  defp exists_in_radcheck!(username) do
    Repo.get_by!(Radcheck, username: username)
  end

  defp exists_in_radusergroup!(username) do
    Repo.get_by!(Radusergroup, username: username)
  end
end

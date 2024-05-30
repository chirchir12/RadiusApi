defmodule RadiusApi.Network do
  alias RadiusApi.Users
  alias RadiusApi.Policies
  alias RadiusApi.Repo

  def add_user_to_network(%{"email" => email, "type" => type}) do
    with {:ok, user} <- Users.get_by_email(email),
         {:ok, _} <- Policies.check_if_exists!(type) do
      Ecto.Multi.new()
      |> Policies.add_radcheck(%{
        username: user.email,
        attribute: "Cleartext-Password",
        op: ":=",
        value: user.password
      })
      |> Policies.add_radusergroup(%{
        username: user.email,
        groupname: type,
        priority: 3
      })
      |> Repo.transaction()
    end
  end
end

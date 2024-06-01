defmodule RadiusApi.Users do
  import Ecto.Query
  alias RadiusApi.Repo
  alias RadiusApi.Users.{User, UserDevice}

  def create_user(attr) do
    %User{}
    |> User.changeset(attr)
    |> Repo.insert()
    |> case do
      {:ok, user} ->
        user = Repo.preload(user, :user_devices)
        {:ok, user}

      error ->
        error
    end
  end

  def get_user!(id) do
    Repo.get!(User, id) |> Repo.preload(:user_devices)
  end

  def get_by_email(email) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, "user_not_found"}
      user -> {:ok, Repo.preload(user, :user_devices)}
    end
  end

  def list_users() do
    # password is cleartext because of PAP protocol
    query = from(u in User, select: {u.id, u.email, u.firstname, u.password, u.lastname})

    Repo.all(query)
    |> Enum.map(&from_tuple/1)
  end

  def update(%User{} = user, attr) do
    user
    |> User.changeset(attr)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def create_user_device(attr) do
    %UserDevice{}
    |> UserDevice.changeset(attr)
    |> Repo.insert()
  end

  def get_device!(id) do
    Repo.get!(UserDevice, id)
  end

  def update_device(device, attrs) do
    device
    |> UserDevice.changeset(attrs)
    |> Repo.update()
  end

  def get_devices() do
    query = from(d in UserDevice, select: {d.id, d.type, d.mac, d.user_id})

    Repo.all(query)
    |> Enum.map(&from_tuple/1)
  end

  def delete_device(%UserDevice{} = device) do
    Repo.delete(device)
  end

  defp from_tuple({id, email, firstname, password, lastname}) do
    %User{
      id: id,
      email: email,
      firstname: firstname,
      lastname: lastname,
      password: password
    }
  end

  defp from_tuple({id, type, mac, user_id}) do
    %UserDevice{
      id: id,
      user_id: user_id,
      mac: mac,
      type: type
    }
  end
end

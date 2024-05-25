defmodule RadiusApi.Users do
  alias RadiusApi.Repo
  alias RadiusApi.Users.{User, UserDevice}

  def create_user(attr) do
    %User{}
    |> User.changeset(attr)
    |> Repo.insert()
  end

  def get_user!(id) do
    Repo.get!(User, id) |> Repo.preload(:user_devices)
  end

  def list_users() do
    Repo.all(User)
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
    Repo.all(UserDevice)
  end

  def delete_device(%UserDevice{} = device) do
    Repo.delete(device)
  end
end

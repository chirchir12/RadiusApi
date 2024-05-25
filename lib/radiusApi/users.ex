defmodule RadiusApi.Users do
  alias RadiusApi.Repo
  alias RadiusApi.Users.User

  def create_user(attr) do
    %User{}
    |> User.changeset(attr)
    |> Repo.insert()
  end

  def get_user!(id) do
    Repo.get!(User, id)
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
end

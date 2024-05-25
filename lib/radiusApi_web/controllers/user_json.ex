defmodule RadiusApiWeb.UserJSON do
  alias RadiusApi.Users.User

  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      email: user.email,
      firstname: user.firstname,
      lastname: user.lastname,
      password: user.password
    }
  end
end

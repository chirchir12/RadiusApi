defmodule RadiusApiWeb.UserController do
  use RadiusApiWeb, :controller

  alias RadiusApi.Users
  alias RadiusApi.Users.{User}

  action_fallback RadiusApiWeb.FallbackController

  def create_user(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render(:show, user: user)
    end
  end

  def get_user(conn, %{"id" => id}) do
    with user <- Users.get_user!(id) do
      conn
      |> put_status(:ok)
      |> render(:show, user: user)
    end
  end

  def get_users(conn, _params) do
    users = Users.list_users()

    conn
    |> put_status(:ok)
    |> render(:index, users: users)
  end

  def update_user(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, user} <- Users.update(user, user_params) do
      conn
      |> put_status(:ok)
      |> render(:show, user: user)
    end
  end

  def delete_user(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      conn
      |> send_resp(:no_content, "")
    end
  end
end

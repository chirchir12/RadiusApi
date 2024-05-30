defmodule RadiusApiWeb.UserController do
  use RadiusApiWeb, :controller

  alias RadiusApi.Users
  alias RadiusApi.Users.{User, UserDevice}

  action_fallback RadiusApiWeb.FallbackController

  def create_user(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render(:show, user: user)
    end
  end

  def get_user(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    conn
    |> put_status(:ok)
    |> render(:show, user: user)
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

  def create_user_device(conn, %{"id" => id, "device" => device}) do
    params = Map.put(device, "user_id", id)

    with {:ok, %UserDevice{} = device} <- Users.create_user_device(params) do
      conn
      |> put_status(:created)
      |> render(:show, device: device)
    end
  end

  def get_device(conn, %{"id" => id}) do
    device = Users.get_device!(id)

    conn
    |> put_status(:ok)
    |> render(:show, device: device)
  end

  def update_device(conn, %{"id" => id, "device" => device_params}) do
    device = Users.get_device!(id)

    with {:ok, %UserDevice{} = device} <- Users.update_device(device, device_params) do
      conn
      |> put_status(:ok)
      |> render(:show, device: device)
    end
  end

  def get_devices(conn, _params) do
    devices = Users.get_devices()

    conn
    |> put_status(:ok)
    |> render(:index, devices: devices)
  end

  def delete_device(conn, %{"id" => id}) do
    device = Users.get_device!(id)

    with {:ok, %UserDevice{}} <- Users.delete_device(device) do
      conn
      |> send_resp(:no_content, "")
    end
  end
end

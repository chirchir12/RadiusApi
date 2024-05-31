defmodule RadiusApiWeb.UserJSON do
  alias RadiusApi.Users.{User, UserDevice}

  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  def index(%{devices: devices}) do
    %{data: for(device <- devices, do: data(device))}
  end

  def show(%{user: %User{user_devices: devices} = user}) when is_list(devices) do
    %{data: data(user, devices)}
  end

  def show(%{user: %User{} = user}) do
    %{data: data(user)}
  end

  def show(%{device: %UserDevice{} = device}) do
    %{data: data(device)}
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

  defp data(%UserDevice{} = device) do
    %{
      id: device.id,
      type: device.type,
      mac: EctoNetwork.MACADDR.decode(device.mac)
    }
  end

  defp data(%User{} = user, devices) when is_list(devices) do
    %{
      id: user.id,
      email: user.email,
      firstname: user.firstname,
      lastname: user.lastname,
      password: user.password,
      devices: for(device <- devices, do: data(device))
    }
  end

  defp data(%User{} = user, %UserDevice{} = device) do
    %{
      id: user.id,
      email: user.email,
      firstname: user.firstname,
      lastname: user.lastname,
      password: user.password,
      devices: data(device)
    }
  end

  def prep_data(items) when is_list(items) do
    for(item <- items, do: data(item))
  end
end

defmodule RadiusApiWeb.NasController do
  use RadiusApiWeb, :controller

  alias RadiusApi.Devices
  alias RadiusApi.Devices.Nas

  action_fallback RadiusApiWeb.FallbackController

  def index(conn, _params) do
    nas = Devices.list_nas()
    render(conn, :index, nas: nas)
  end

  def create(conn, %{"nas" => nas_params}) when is_map(nas_params) do
    with {:ok, %Nas{} = nas} <- Devices.create_nas(nas_params) do
      conn
      |> put_status(:created)
      |> render(:show, nas: nas)
    end
  end

  def show(conn, %{"id" => id}) do
    nas = Devices.get_nas!(id)
    render(conn, :show, nas: nas)
  end

  def update(conn, %{"id" => id, "nas" => nas_params}) do
    nas = Devices.get_nas!(id)

    with {:ok, %Nas{} = nas} <- Devices.update_nas(nas, nas_params) do
      render(conn, :show, nas: nas)
    end
  end

  def delete(conn, %{"id" => id}) do
    nas = Devices.get_nas!(id)

    with {:ok, %Nas{}} <- Devices.delete_nas(nas) do
      send_resp(conn, :no_content, "")
    end
  end
end

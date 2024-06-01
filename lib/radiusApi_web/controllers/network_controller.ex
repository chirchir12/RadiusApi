defmodule RadiusApiWeb.NetworkController do
  use RadiusApiWeb, :controller

  alias RadiusApi.Network

  action_fallback RadiusApiWeb.FallbackController

  def add_to_network(conn, %{"data" => data}) do
    case Network.add_user_to_network(data) do
      {:ok, _results} ->
        conn
        |> put_status(:created)
        |> render(:add, data: %{status: "ok"})

      {:error, "group_name_not_found" = message} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(json: RadiusApiWeb.ErrorJSON)
        |> render("422.json", error: %{message: message})

      {:error, "user_not_found" = message} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(json: RadiusApiWeb.ErrorJSON)
        |> render("422.json", error: %{message: message})

      {:error, "insert_radcheck", %Ecto.Changeset{} = changeset, _} ->
        {:error, "insert_radcheck", changeset}

      {:error, "insert_usergroup", %Ecto.Changeset{} = changeset, _} ->
        {:error, "insert_usergroup", changeset}
    end
  end

  def remove_from_network(conn, %{"criteria" => %{"email" => email}}) do
    with {:ok, _result} <- Network.remove_user_from_network(email) do
      send_resp(conn, :no_content, "")
    end
  end
end

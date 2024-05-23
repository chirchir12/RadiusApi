defmodule RadiusApiWeb.NasControllerTest do
  use RadiusApiWeb.ConnCase

  import RadiusApi.DevicesFixtures

  alias RadiusApi.Devices.Nas

  @create_attrs %{
    ports: 24,
    type: "other",
    description: "some description",
    server: "172.45.3.3",
    nasname: "192.168.1.1",
    secret: "secret",
    community: "some community",
    shortname: "mikrotik"
  }
  @update_attrs %{
    ports: 48,
    type: "other",
    description: "some updated description",
    server: "172.45.3.3",
    secret: "secret",
    community: "some updated community"
  }
  @invalid_attrs %{ports: nil, server: nil, nasname: nil, secret: nil, shortname: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all nas", %{conn: conn} do
      conn = get(conn, ~p"/api/nas")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create nas" do
    test "renders nas when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/nas", nas: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/nas/#{id}")

      assert %{
               "id" => ^id,
               "community" => "some community",
               "description" => "some description",
               "nasname" => "192.168.1.1",
               "ports" => 24,
               "secret" => "secret",
               "server" => "172.45.3.3",
               "type" => "other"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/nas", nas: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update nas" do
    setup [:create_nas]

    test "renders nas when data is valid", %{conn: conn, nas: %Nas{id: id} = nas} do
      conn = put(conn, ~p"/api/nas/#{nas}", nas: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/nas/#{id}")

      assert %{
               "id" => ^id,
               "community" => "some updated community",
               "description" => "some updated description",
               "ports" => 48,
               "secret" => "secret",
               "server" => "172.45.3.3",
               "type" => "other"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, nas: nas} do
      conn = put(conn, ~p"/api/nas/#{nas}", nas: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete nas" do
    setup [:create_nas]

    test "deletes chosen nas", %{conn: conn, nas: nas} do
      conn = delete(conn, ~p"/api/nas/#{nas}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/nas/#{nas}")
      end
    end
  end

  defp create_nas(_) do
    nas = nas_fixture()
    %{nas: nas}
  end
end

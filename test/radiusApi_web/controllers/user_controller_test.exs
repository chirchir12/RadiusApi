defmodule RadiusApiWeb.UserControllerTest do
  alias RadiusApi.Users.UserDevice
  alias Hex.API.User
  use RadiusApiWeb.ConnCase
  import RadiusApi.UsersFixtures
  alias RadiusApi.Users.User

  @create_user_attrs %{
    email: "test@gmail.com",
    firstname: "firstname",
    lastname: "firstname",
    password: "password"
  }

  @update_user_attrs %{
    firstname: "firstname_changed",
    lastname: "lastname_changed",
    password: "password_changed"
  }

  @invalid_user_attrs %{firstname: nil, lastname: nil, password: nil}

  @create_device_attrs %{
    type: "phone",
    mac: "da:c4:48:45:5e:75"
  }

  @update_device_attrs %{
    type: "tablet",
    mac: "da:c4:48:45:5e:75"
  }

  @invalid_attrs %{type: nil, mac: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create_user" do
    test "should render user after its created", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: @create_user_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/users/#{id}")

      assert %{
               "id" => ^id,
               "email" => "test@gmail.com",
               "firstname" => "firstname",
               "lastname" => "firstname",
               "password" => "password"
             } = json_response(conn, 200)["data"]
    end

    test "should render errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: @invalid_user_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "get_user" do
    setup [:create_user]

    test "should return exising user", %{conn: conn, user: %User{id: id}} do
      conn = get(conn, ~p"/api/users/#{id}")

      assert %{
               "id" => ^id,
               "email" => "test@gmail.com",
               "firstname" => "firstname",
               "lastname" => "lastname",
               "password" => "password"
             } = json_response(conn, 200)["data"]
    end

    test "should return 404 for users not created yet", %{conn: conn} do
      assert_error_sent 404, fn ->
        get(conn, ~p"/api/users/100")
      end
    end
  end

  describe "get_users" do
    test "list users", %{conn: conn} do
      conn = get(conn, ~p"/api/users")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "update_user" do
    setup [:create_user]

    test "should update existing user", %{conn: conn, user: %User{id: id}} do
      conn = put(conn, ~p"/api/users/#{id}", user: @update_user_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      assert %{
               "id" => ^id,
               "email" => "test@gmail.com",
               "firstname" => "firstname_changed",
               "lastname" => "lastname_changed",
               "password" => "password_changed"
             } = json_response(conn, 200)["data"]
    end

    test "should throw error for invalid data", %{conn: conn, user: %User{id: id}} do
      conn = put(conn, ~p"/api/users/#{id}", user: @invalid_user_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete_user" do
    setup [:create_user]

    test "should delete existing user", %{conn: conn, user: %User{id: id}} do
      conn = delete(conn, ~p"/api/users/#{id}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/users/#{id}")
      end
    end
  end

  describe "create_user_device" do
    setup [:create_user]

    test "should render after creating user device", %{
      conn: conn,
      user: %User{id: user_id}
    } do
      conn = post(conn, ~p"/api/users/#{user_id}/devices", device: @create_device_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      assert %{
               "id" => ^id,
               "type" => "phone",
               "mac" => "DA:C4:48:45:5E:75"
             } = json_response(conn, 201)["data"]
    end

    test "should throw with invalid data", %{conn: conn, user: %User{id: user_id}} do
      conn = post(conn, ~p"/api/users/#{user_id}/devices", device: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "get_device" do
    setup [:create_device]

    test "should get existing device", %{conn: conn, device: %UserDevice{id: id}} do
      conn = get(conn, ~p"/api/devices/#{id}")

      assert %{
               "id" => ^id,
               "type" => "phone"
             } = json_response(conn, 200)["data"]
    end

    test "should return 404 for devices not created yet", %{conn: conn} do
      assert_error_sent 404, fn ->
        get(conn, ~p"/api/devices/100")
      end
    end
  end

  describe "update_device" do
    setup [:create_device]

    test "should update existing device", %{conn: conn, device: %UserDevice{id: id}} do
      conn = put(conn, ~p"/api/devices/#{id}", device: @update_device_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      assert %{
               "id" => ^id,
               "type" => "tablet",
               "mac" => "DA:C4:48:45:5E:75"
             } = json_response(conn, 200)["data"]
    end

    test "should throw if data is invalid", %{conn: conn, device: %UserDevice{id: id}} do
      conn = put(conn, ~p"/api/devices/#{id}", device: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "get_devices" do
    test "to list devices", %{conn: conn} do
      conn = get(conn, ~p"/api/devices")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "delete_device" do
    setup [:create_device]

    test "to delete existing device", %{conn: conn, device: %UserDevice{id: id}} do
      conn = delete(conn, ~p"/api/devices/#{id}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/devices/#{id}")
      end
    end
  end

  defp create_user(_) do
    user = create_user_fixture()
    %{user: user}
  end

  defp create_device(_) do
    device = create_user_device_fixture()
    %{device: device}
  end
end

defmodule RadiusApi.NetworkControllerTest do
  alias RadiusApi.Users.User
  use RadiusApiWeb.ConnCase

  import RadiusApi.NetworkFixtures
  import RadiusApi.UsersFixtures, only: [create_user_fixture: 1]

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "add_to_network" do
    setup [:seed_policies, :create_user]

    test "existing user is added to network as admin", %{conn: conn, user: %User{email: email}} do
      attrs = %{"email" => email, "type" => "admin"}
      conn = post(conn, ~p"/api//network/add/user", data: attrs)
      assert %{"status" => "ok"} == json_response(conn, 200)["data"]

      # adding again should throw error if user has the same email
      conn = post(conn, ~p"/api//network/add/user", data: attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end

    test "should throw if user does not exists", %{conn: conn} do
      attrs = %{"email" => "doesnotexist@email.com", "type" => "admin"}
      conn = post(conn, ~p"/api//network/add/user", data: attrs)
      assert %{"status" => "user_not_found"} = json_response(conn, 422)["error"]
    end

    test "should throw if policy does not exists", %{conn: conn, user: %User{email: email}} do
      attrs = %{"email" => email, "type" => "notpolicy"}
      conn = post(conn, ~p"/api//network/add/user", data: attrs)
      assert %{"status" => "group_name_not_found"} = json_response(conn, 422)["error"]
    end
  end

  describe "remove_from_network" do
    setup [:seed_policies, :create_user, :add_to_network]
    test "to remove user from network", %{conn: conn, user: user} do
      attrs = %{"email" => user.email}
      conn = post(conn, ~p"/api/network/remove/user", criteria: attrs)
      assert response(conn, 204)
    end
  end

  defp create_user(_) do
    user = create_user_fixture(%{})
    %{user: user}
  end

  defp add_to_network(%{user: user}) do
    attrs = %{"email" => user.email, "type" => "admin"}
    _ = RadiusApi.Network.add_user_to_network(attrs)
    :ok

  end

  defp seed_policies(_) do
    {:ok, _data} = seed_policies()
    :ok
  end
end

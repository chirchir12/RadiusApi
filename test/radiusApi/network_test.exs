defmodule RadiusApi.NetworkTest do
  use RadiusApi.DataCase
  alias RadiusApi.Network
  alias RadiusApi.Policies.Radcheck
  alias RadiusApi.Policies.Radusergroup

  import RadiusApi.NetworkFixtures
  import RadiusApi.UsersFixtures

  describe "network" do
    setup [:seed_policies]

    test "add_user_to_network/2 add user to network" do
      user = create_user_fixture()
      attrs = %{"email" => user.email, "type" => "admin"}

      assert {:ok, %{"insert_radcheck" => %Radcheck{}, "insert_usergroup" => %Radusergroup{}}} =
               Network.add_user_to_network(attrs)
    end

    test "add_user_to_network/2 with invalid email should return error" do
      attrs = %{"email" => "email@email.com", "type" => "admin"}
      assert {:error, "user_not_found"} == Network.add_user_to_network(attrs)
    end

    test "add_user_to_network/2 with invalid policy should return error" do
      user = create_user_fixture()
      attrs = %{"email" => user.email, "type" => "notexist"}
      assert {:error, "group_name_not_found"} == Network.add_user_to_network(attrs)
    end

    test "remove_user_from_network/1 should remove existing user from the network" do
      user = create_user_fixture()
      _ = add_user_to_network(user)

      assert {:ok, %{delete_radcheck: %Radcheck{}, delete_radusergroup: %Radusergroup{}}} =
               Network.remove_user_from_network(user.email)
    end

    test "remove_user_from_network/1 should throw if user does not exist" do
      assert {:error, "user_not_found"} ==
               Network.remove_user_from_network("test")
    end
  end

  defp seed_policies(_) do
    _ = seed_policies()
    :ok
  end

  defp add_user_to_network(user) do
    attrs = %{"email" => user.email, "type" => "admin"}
    _ = Network.add_user_to_network(attrs)
    :ok
  end
end

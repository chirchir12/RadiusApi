defmodule RadiusApi.DevicesTest do
  use RadiusApi.DataCase

  alias RadiusApi.Devices

  describe "nas" do
    alias RadiusApi.Devices.Nas

    import RadiusApi.DevicesFixtures

    @invalid_attrs %{ports: nil, server: nil, nasname: nil, secret: nil, shortname: nil}

    test "list_nas/0 returns all nas" do
      nas = nas_fixture()
      assert Devices.list_nas() == [nas]
    end

    test "get_nas!/1 returns the nas with given id" do
      nas = nas_fixture()
      assert Devices.get_nas!(nas.id) == nas
    end

    test "create_nas/1 with valid data creates a nas" do
      valid_attrs = %{
        ports: 48,
        type: "other",
        description: "some description",
        server: "207.40.4.33",
        nasname: "192.56.32.2",
        secret: "secret",
        community: "some community",
        shortname: "mikrotik"
      }

      assert {:ok, %Nas{} = nas} = Devices.create_nas(valid_attrs)
      assert nas.ports == 48
      assert nas.type == "other"
      assert nas.description == "some description"
      assert nas.server == "207.40.4.33"
      assert nas.nasname == "192.56.32.2"
      assert nas.secret == "secret"
      assert nas.community == "some community"
      assert nas.shortname == "mikrotik"
    end

    test "create_nas/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Devices.create_nas(@invalid_attrs)
    end

    test "update_nas/2 with valid data updates the nas" do
      nas = nas_fixture()
      update_attrs = %{server: "208.47.204.89", secret: "secret2"}

      assert {:ok, %Nas{} = nas} = Devices.update_nas(nas, update_attrs)
      assert nas.ports == 34
      assert nas.type == "other"
      assert nas.description == "some description"
      assert nas.server == "208.47.204.89"
      assert nas.nasname == "5.5.5.5"
      assert nas.secret == "secret2"
      assert nas.community == "some community"
      assert nas.shortname == "mikrotik"
    end

    test "update_nas/2 with invalid data returns error changeset" do
      nas = nas_fixture()
      assert {:error, %Ecto.Changeset{}} = Devices.update_nas(nas, @invalid_attrs)
      assert nas == Devices.get_nas!(nas.id)
    end

    test "delete_nas/1 deletes the nas" do
      nas = nas_fixture()
      assert {:ok, %Nas{}} = Devices.delete_nas(nas)
      assert_raise Ecto.NoResultsError, fn -> Devices.get_nas!(nas.id) end
    end

    test "change_nas/1 returns a nas changeset" do
      nas = nas_fixture()
      assert %Ecto.Changeset{} = Devices.change_nas(nas)
    end
  end
end

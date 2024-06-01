defmodule RadiusApi.UsersTest do
  use RadiusApi.DataCase
  alias RadiusApi.Users
  import RadiusApi.UsersFixtures

  describe "users" do
    alias RadiusApi.Users.User

    @invalid_attrs %{email: nil, firstname: nil, password: nil, lastname: nil}

    test "list_users/0 return list of users" do
      user = create_user_fixture()

      assert Users.list_users() == [
               %User{
                 id: user.id,
                 email: user.email,
                 firstname: user.firstname,
                 lastname: user.lastname,
                 password: user.password
               }
             ]
    end

    test "get_user!/1 return single user" do
      user = create_user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "get_by_email/1 return user specified by email" do
      user = create_user_fixture()
      assert Users.get_by_email(user.email) == {:ok, user}
    end

    test "create_user/1 create user when passed correct attributes" do
      valid_attrs = %{
        email: "test@gmail.com",
        firstname: "firstname",
        lastname: "lastname",
        password: "password"
      }

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.email == "test@gmail.com"
      assert user.firstname == "firstname"
      assert user.lastname == "lastname"
      assert user.password == "password"
      assert length(user.user_devices) == 0
    end

    test "create_user/1 create user when passed incorrect attributes" do
      # this will work because its match operator
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "create_user/1 create user with existing email raises error" do
      _ = create_user_fixture()

      valid_attrs = %{
        email: "test@gmail.com",
        firstname: "firstname",
        lastname: "lastname",
        password: "password"
      }

      assert {:error, %Ecto.Changeset{}} = Users.create_user(valid_attrs)
    end

    test "update/2 update user with valid attributes" do
      user = create_user_fixture()

      valid_attrs = %{
        firstname: "firstname_changed",
        lastname: "lastname_changed",
        password: "password_changed",
        email: user.email
      }

      assert {:ok, %User{} = user} = Users.update(user, valid_attrs)
      assert user.firstname == "firstname_changed"
      assert user.lastname == "lastname_changed"
      assert user.password == "password_changed"
      assert user.email == user.email
    end

    test "update/2 update user with invalid attributes" do
      user = create_user_fixture()

      attrs = %{
        firstname: nil
      }

      assert {:error, %Ecto.Changeset{}} = Users.update(user, attrs)
    end

    test "delete_user/1 should delete existing user" do
      user = create_user_fixture()
      assert {:ok, user} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end
  end

  describe "user_devices" do
    alias RadiusApi.Users.UserDevice

    test "get_devices/0 return lists of devices attached to a user" do
      phone = create_user_device_fixture()

      assert Users.get_devices() == [
               %UserDevice{id: phone.id, mac: phone.mac, type: phone.type, user_id: phone.user_id}
             ]
    end

    test "get_device!/1 should return existing devices" do
      phone = create_user_device_fixture()
      assert Users.get_device!(phone.id) == phone
    end

    test "create_user_device/1 should create user device with valid attributes" do
      user = create_user_fixture()

      atttrs = %{
        user_id: user.id,
        type: "phone",
        mac: "da:c4:48:45:5e:75"
      }

      assert {:ok, %UserDevice{} = device} = Users.create_user_device(atttrs)
      assert EctoNetwork.MACADDR.decode(device.mac) == String.upcase("da:c4:48:45:5e:75")
      assert device.type == "phone"
      assert device.user_id == user.id
    end

    test "create_user_device/1 should raise if mac address is invalid" do
      user = create_user_fixture()

      atttrs = %{
        user_id: user.id,
        type: "phone",
        mac: "da:c4:48:45"
      }

      assert {:error, %Ecto.Changeset{}} = Users.create_user_device(atttrs)
    end

    test "create_user_device/1 should raise if type is invalid" do
      user = create_user_fixture()

      atttrs = %{
        user_id: user.id,
        type: "something",
        mac: "da:c4:48:45:5e:75"
      }

      assert {:error, %Ecto.Changeset{}} = Users.create_user_device(atttrs)
    end

    test "update_device/2 should update existing device" do
      phone = create_user_device_fixture()

      attrs = %{
        type: "watch",
        mac: phone.mac
      }

      assert {:ok, %UserDevice{} = device} = Users.update_device(phone, attrs)
      assert device.type == "watch"
      assert device.mac == phone.mac
    end

    test "delete_device/1 should delete existing record" do
      phone = create_user_device_fixture()
      assert {:ok, %UserDevice{}} = Users.delete_device(phone)
      assert_raise Ecto.NoResultsError, fn -> Users.get_device!(phone.id) end
    end
  end
end

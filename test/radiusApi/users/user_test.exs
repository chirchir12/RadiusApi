defmodule RadiusApi.Users.UserTest do
  use RadiusApi.DataCase, async: true
  alias RadiusApi.Users.User

  test "changeset/2 should return valid changeset" do
    attrs = %{
      email: "email@mail.com",
      firstname: "lastname",
      password: "password"
    }

    changeset = User.changeset(%User{}, attrs)
    assert %Ecto.Changeset{} = changeset
    assert changeset.valid? == true
  end

  test "changeset/2 should return invalid changeset when required param is missing" do
    attrs = %{
      email: "email@mail.com",
      lastname: "lastname",
      password: "password"
    }

    changeset = User.changeset(%User{}, attrs)
    assert %Ecto.Changeset{} = changeset
    assert changeset.valid? == false
  end

  test "changeset/2 should return invalid changeset when email is not valid" do
    attrs = %{
      email: "email",
      firstname: "lastname",
      password: "password"
    }

    changeset = User.changeset(%User{}, attrs)
    assert %Ecto.Changeset{} = changeset
    refute changeset.valid?
  end
end

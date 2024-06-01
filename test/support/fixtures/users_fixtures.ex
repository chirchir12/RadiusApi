defmodule RadiusApi.UsersFixtures do
  def create_user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "test@gmail.com",
        firstname: "firstname",
        lastname: "lastname",
        password: "password"
      })
      |> RadiusApi.Users.create_user()

    user
  end

  def create_user_device_fixture(attrs \\ %{}) do
    user = create_user_fixture()

    {:ok, device} =
      attrs
      |> Enum.into(%{
        type: "phone",
        mac: "da:c4:48:45:5e:75",
        user_id: user.id
      })
      |> RadiusApi.Users.create_user_device()

    device
  end
end

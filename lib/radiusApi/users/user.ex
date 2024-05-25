defmodule RadiusApi.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @mail_regex ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/

  @permitted [
    :email,
    :firstname,
    :lastname,
    :password
  ]

  @required [
    :email,
    :firstname,
    :password
  ]

  schema "users" do
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :password, :string
    has_many :user_devices, RadiusApi.Users.UserDevice
    timestamps(type: :utc_datetime)
  end

  def changeset(t, attr \\ %{}) do
    t
    |> cast(attr, @permitted)
    |> validate_required(@required)
    |> validate_format(:email, @mail_regex)
    |> unique_constraint(:email)
  end
end

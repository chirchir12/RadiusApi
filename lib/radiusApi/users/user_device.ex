defmodule RadiusApi.Users.UserDevice do
  use Ecto.Schema
  import Ecto.Changeset

  @allowed_types ["phone", "tablet", "laptop", "watch"]

  @permitted [
    :type,
    :mac,
    :user_id
  ]

  @required [
    :type,
    :mac,
    :user_id
  ]

  schema "user_devices" do
    field :type, :string
    field :mac, EctoNetwork.MACADDR
    belongs_to :user, RadiusApi.Users.User
    timestamps(type: :utc_datetime)
  end

  def changeset(t, attrs \\ %{}) do
    t
    |> cast(attrs, @permitted)
    |> validate_required(@required)
    |> validate_type(:type)
    |> foreign_key_constraint(:user_id)
    |> unique_constraint(:mac)
  end

  defp validate_type(changeset, field) do
    type = changeset |> get_change(field)

    case type in @allowed_types do
      true -> changeset
      false -> changeset |> add_error(field, "type is not allowed")
    end
  end
end

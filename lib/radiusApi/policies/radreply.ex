defmodule RadiusApi.Policies.Radreply do
  use Ecto.Schema
  import Ecto.Changeset

  @permitted [
    :username,
    :attribute,
    :op,
    :value
  ]

  @required [
    :username,
    :attribute,
    :op,
    :value
  ]

  schema "radreply" do
    field :username, :string, source: :UserName
    field :attribute, :string, source: :Attribute
    field :op, :string
    field :value, :string, source: :Value
    timestamps(type: :utc_datetime)
  end

  def changeset(t, attr \\ %{}) do
    t
    |> cast(attr, @permitted)
    |> validate_required(@required)
  end
end

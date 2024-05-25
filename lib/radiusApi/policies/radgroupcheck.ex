defmodule RadiusApi.Policies.Radgroupcheck do
  use Ecto.Schema
  import Ecto.Changeset

  @permitted [
    :group_name,
    :attribute,
    :op,
    :value
  ]

  @required [
    :group_name,
    :attribute,
    :op,
    :value
  ]

  schema "radgroupcheck" do
    field :group_name, :string, source: :GroupName
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

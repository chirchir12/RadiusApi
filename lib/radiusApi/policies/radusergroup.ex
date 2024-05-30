defmodule RadiusApi.Policies.Radusergroup do
  use Ecto.Schema
  import Ecto.Changeset

  @permitted [
    :username,
    :groupname,
    :priority
  ]

  @required [
    :username,
    :groupname,
    :priority
  ]

  schema "radusergroup" do
    field :username, :string, source: :UserName
    field :groupname, :string, source: :GroupName
    field :priority, :integer

    timestamps(type: :utc_datetime)
  end

  def changeset(t, attr \\ %{}) do
    t
    |> cast(attr, @permitted)
    |> validate_required(@required)
    |> unique_constraint([:username, :groupname, :priority])
  end
end

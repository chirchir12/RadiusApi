defmodule RadiusApi.Devices.Nas do
  use Ecto.Schema
  import Ecto.Changeset

  @permitted [
    :nasname,
    :type,
    :ports,
    :secret,
    :server,
    :community,
    :description
  ]

  @required [
    :nasname,
    :type,
    :ports,
    :secret,
    :server
  ]

  schema "nas" do
    field :ports, :integer
    field :type, :string, default: "other"
    field :description, :string
    field :server, :string
    field :nasname, :string
    field :secret, :string
    field :community, :string
    field :shortname, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(nas, attrs) do
    nas
    |> cast(attrs, @permitted)
    |> validate_required(@required)
  end
end

defmodule RadiusApi.Devices.NasReload do
  use Ecto.Schema
  import Ecto.Changeset


  schema "nasreload" do
    field :nas_ip_address, EctoNetwork.INET, source: :NASIPAddress
    field :reload_time, :utc_datetime, source: :ReloadTime
    timestamps(type: :utc_datetime)
  end

  def changeset(t, attrs) do
    t
    |> cast(attrs, [:nas_ip_address, :reload_time ])
    |> validate_required([:nas_ip_address, :reload_time])

  end




end

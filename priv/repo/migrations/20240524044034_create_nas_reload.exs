defmodule RadiusApi.Repo.Migrations.CreateNasReload do
  use Ecto.Migration

  def change do
    create table(:nasreload) do
      add :NASIPAddress, :inet
      add :ReloadTime, :utc_datetime
      timestamps(type: :utc_datetime)
    end
  end
end

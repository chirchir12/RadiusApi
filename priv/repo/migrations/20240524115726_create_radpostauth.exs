defmodule RadiusApi.Repo.Migrations.CreateRadpostauth do
  use Ecto.Migration

  def change do
    create table(:radpostauth) do
      add :username, :text, null: false
      add :pass, :text
      add :reply, :text
      add :CalledStationId, :text
      add :CallingStationId, :text
      add :authdate, :utc_datetime
      add :Class, :text
      timestamps(type: :utc_datetime)
    end
  end
end

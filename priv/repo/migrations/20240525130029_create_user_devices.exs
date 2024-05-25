defmodule RadiusApi.Repo.Migrations.CreateUserDevices do
  use Ecto.Migration

  def change do
    create table(:user_devices) do
      add :type, :string, null: false
      add :mac, :macaddr, null: false
      add :user_id, references(:users, on_delete: :delete_all)
      timestamps(type: :utc_datetime)
    end

    create unique_index(:user_devices, [:mac])
  end
end

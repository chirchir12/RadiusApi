defmodule RadiusApi.Repo.Migrations.CreateRadusergroup do
  use Ecto.Migration

  def change do
    create table(:radusergroup) do
      add :UserName, :text, null: false, default: ""
      add :GroupName, :text, null: false, default: ""
      add :priority, :integer, null: false, default: 0

      timestamps(type: :utc_datetime)
    end
    create index(:radusergroup, [:UserName], name: :radusergroup_UserName)

  end
end

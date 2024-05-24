defmodule RadiusApi.Repo.Migrations.CreateRadgroupreply do
  use Ecto.Migration

  def change do
    create table(:radgroupreply) do
      add :GroupName, :string, null: false, default: ""
      add :Attribute, :string, null: false, default: ""
      add :op, :string, null: false, default: "=="
      add :Value, :string, null: false, default: ""
      timestamps(type: :utc_datetime)
    end

    create index(:radgroupreply, [:GroupName,:Attribute], name: :radgroupreply_GroupName)

  end
end

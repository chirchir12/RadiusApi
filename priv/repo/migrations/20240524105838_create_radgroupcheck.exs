defmodule RadiusApi.Repo.Migrations.CreateRadgroupcheck do
  use Ecto.Migration

  def change do
    create table(:radgroupcheck) do
      add :GroupName, :string, null: false, default: ""
      add :Attribute, :string, null: false, default: ""
      add :op, :string, null: false, default: "=="
      add :Value, :string, null: false, default: ""
      timestamps(type: :utc_datetime)
    end

    create index(:radgroupcheck, [:GroupName, :Attribute], name: :radgroupcheck_GroupName)
  end
end

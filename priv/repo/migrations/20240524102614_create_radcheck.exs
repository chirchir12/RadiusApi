defmodule RadiusApi.Repo.Migrations.CreateRadcheck do
  use Ecto.Migration

  def change do
    create table(:radcheck) do
      add :UserName, :text, null: false, default: ""
      add :Attribute, :text, null: false, default: ""
      add :op, :string, null: false, default: "=="
      add :Value, :text, null: false, default: ""

      timestamps(type: :utc_datetime)
    end
    create index(:radcheck, [:UserName,:Attribute], name: :radcheck_UserName)

  end
end

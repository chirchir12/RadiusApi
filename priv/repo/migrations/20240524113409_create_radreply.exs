defmodule RadiusApi.Repo.Migrations.CreateRadreply do
  use Ecto.Migration

  def change do
    create table(:radreply) do
      add :UserName, :text, null: false, default: ""
      add :Attribute, :text, null: false, default: ""
      add :op, :string, null: false, default: "=="
      add :Value, :text, null: false, default: ""

      timestamps(type: :utc_datetime)
    end

    create index(:radreply, [:UserName, :Attribute], name: :radreply_UserName)
  end
end

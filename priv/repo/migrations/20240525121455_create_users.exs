defmodule RadiusApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :firstname, :string, null: false
      add :lastname, :string

      # since its going to be Password Authentication Protocol (PAP), this password is going to be in clear text
      add :password, :string, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:email])
  end
end

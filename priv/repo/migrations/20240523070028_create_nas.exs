defmodule RadiusApi.Repo.Migrations.CreateNas do
  use Ecto.Migration

  def change do
    create table(:nas) do
      add :nasname, :string, null: false, comment: "The hostname or IP address of the NAS."
      add :type, :string, default: "other", comment: "The type of NAS, which can be useful for identifying different kinds of NAS devices."
      add :ports, :integer, comment: "The number of ports available on the NAS."
      add :secret, :string, null: false, comment: "The shared secret used for communication between the NAS and the RADIUS server."
      add :server, :string, comment: "Optional field that can specify which RADIUS server to use"
      add :community, :string, comment: "SNMP community string "
      add :description, :string, comment: "A description of the NAS, which can provide additional context or details."
      add :shortname, :string, null: false, comment: "A short, human-readable name for the NAS."

      timestamps(type: :utc_datetime)
    end

    create index(:nas, [:nasname], name: :nas_nasname)
  end
end

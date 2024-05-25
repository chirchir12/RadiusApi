defmodule RadiusApi.Repo.Migrations.CreateRadacct do
  use Ecto.Migration

  def change do
    create table(:radacct, primary_key: false) do
      add :RadAcctId, :bigserial, primary_key: true
      add :AcctSessionId, :string, null: false
      add :AcctUniqueId, :string, null: false
      add :UserName, :string
      add :GroupName, :text
      add :Realm, :text
      add :NASIPAddress, :inet, null: false
      add :NASPortId, :text
      add :NASPortType, :text
      add :AcctStartTime, :utc_datetime
      add :AcctUpdateTime, :utc_datetime
      add :AcctStopTime, :utc_datetime
      add :AcctInterval, :integer
      add :AcctSessionTime, :integer
      add :AcctAuthentic, :text
      add :ConnectInfo_start, :text
      add :ConnectInfo_stop, :text
      add :AcctInputOctets, :integer
      add :AcctOutputOctets, :integer
      add :CalledStationId, :text
      add :CallingStationId, :text
      add :AcctTerminateCause, :text
      add :ServiceType, :text
      add :FramedProtocol, :text
      add :FramedIPAddress, :inet
      add :FramedIPv6Address, :inet
      add :FramedIPv6Prefix, :inet
      add :FramedInterfaceId, :text
      add :DelegatedIPv6Prefix, :inet
      add :Class, :text

      timestamps(type: :utc_datetime)
    end

    unique_index(:radacct, [:AcctUniqueId], name: :radacct_AcctUniqueId_unique)
    create index(:radacct, [:AcctStartTime, :NASIPAddress], name: :radacct_whoson)
    create index(:radacct, [:NASIPAddress, :AcctStartTime], name: :radacct_bulk_close)
    create index(:radacct, [:AcctStartTime, :UserName], name: :radacct_start_user_idx)
    create index(:radacct, [:AcctStopTime, :AcctUpdateTime], name: :radacct_bulk_timeout)
  end
end

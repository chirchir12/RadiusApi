defmodule RadiusApi.Accounting.Radacct do
  use Ecto.Schema
  import Ecto.Changeset

  @permitted [
    :acct_session_id,
    :acct_unique_id,
    :username,
    :group_name,
    :realm,
    :nas_ip_address,
    :nas_port_id,
    :nas_port_type,
    :acct_start_time,
    :acct_update_time,
    :acct_stop_time,
    :acct_interval,
    :acct_session_time,
    :acct_authentic,
    :connect_info_start,
    :connect_info_stop,
    :acct_input_octets,
    :acct_output_octets,
    :called_station_id,
    :calling_station_id,
    :acc_terminate_cause,
    :service_type,
    :framed_protocol,
    :framed_ip_address,
    :framed_ip_v6_address,
    :framed_ip_v6_prefix,
    :framed_interface_id,
    :delegated_ip_v6_prefix,
    :class
  ]

  @required [
    :acct_session_id,
    :acct_unique_id,
    :nas_ip_address
  ]

  @primary_key {:id, :id, autogenerate: true, source: :RadAcctId}
  schema "radacct" do
    field :acct_session_id, :string, source: :AcctSessionId
    field :acct_unique_id, :string, source: :AcctUniqueId
    field :username, :string, source: :UserName
    field :group_name, :string, source: :GroupName
    field :realm, :string, source: :Realm
    field :nas_ip_address, EctoNetwork.INET, source: :NASIPAddress
    field :nas_port_id, :string, source: :NASPortId
    field :nas_port_type, :string, source: :NASPortType
    field :acct_start_time, :utc_datetime, source: :AcctStartTime
    field :acct_update_time, :utc_datetime, source: :AcctUpdateTime
    field :acct_stop_time, :utc_datetime, source: :AcctStopTime
    field :acct_interval, :integer, source: :AcctInterval
    field :acct_session_time, :integer, source: :AcctSessionTime
    field :acct_authentic, :string, source: :AcctAuthentic
    field :connect_info_start, :string, source: :ConnectInfo_start
    field :connect_info_stop, :string, source: :ConnectInfo_stop
    field :acct_input_octets, :integer, source: :AcctInputOctets
    field :acct_output_octets, :integer, source: :AcctOutputOctets
    field :called_station_id, :string, source: :CalledStationId
    field :calling_station_id, :string, source: :CallingStationId
    field :acc_terminate_cause, :string, source: :AcctTerminateCause
    field :service_type, :string, source: :ServiceType
    field :framed_protocol, :string, source: :FramedProtocol
    field :framed_ip_address, EctoNetwork.INET, source: :FramedIPAddress
    field :framed_ip_v6_address, EctoNetwork.INET, source: :FramedIPv6Address
    field :framed_ip_v6_prefix, EctoNetwork.INET, source: :FramedIPv6Prefix
    field :framed_interface_id, :string, source: :FramedInterfaceId
    field :delegated_ip_v6_prefix, EctoNetwork.INET, source: :DelegatedIPv6Prefix
    field :class, :string, source: :Class

    timestamps(type: :utc_datetime)
  end

  def changeset(t, attr \\ %{}) do
    t
    |> cast(attr, @permitted)
    |> validate_required(@required)
  end
end

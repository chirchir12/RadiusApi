defmodule RadiusApiWeb.NasJSON do
  alias RadiusApi.Devices.Nas
  alias RadiusApi.Devices.NasReload

  @doc """
  Renders a list of nas.
  """
  def index(%{nas: nas}) do
    %{data: for(nas <- nas, do: data(nas))}
  end

  @doc """
  Renders a single nas.
  """
  def show(%{nas: nas}) do
    %{data: data(nas)}
  end

  def reload(%{reload: %NasReload{} = reload}) do
    %{
      data: data(reload)
    }
  end

  defp data(%Nas{} = nas) do
    %{
      id: nas.id,
      nasname: nas.nasname,
      type: nas.type,
      ports: nas.ports,
      secret: nas.secret,
      server: nas.server,
      community: nas.community,
      description: nas.description
    }
  end

  defp data(%NasReload{nas_ip_address: ip_address} = reload) when is_binary(ip_address) do
    %{
      nas_ip_address: reload.nas_ip_address,
      reload_time: reload.reload_time
    }
  end

  defp data(%NasReload{} = reload) do
    %{
      nas_ip_address: EctoNetwork.INET.decode(reload.nas_ip_address),
      reload_time: reload.reload_time
    }
  end
end

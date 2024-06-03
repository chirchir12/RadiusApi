defmodule RadiusApiWeb.NasJSONTest do
  use RadiusApiWeb.ConnCase, async: true

  @time DateTime.utc_now()

  @nas %RadiusApi.Devices.Nas{
    id: 1,
    nasname: "1.1.1.1",
    type: "other",
    ports: 24,
    secret: "secret",
    server: "2.2.2.2",
    community: "community",
    description: "description"
  }

  @data %{
    id: 1,
    nasname: "1.1.1.1",
    type: "other",
    ports: 24,
    secret: "secret",
    server: "2.2.2.2",
    community: "community",
    description: "description"
  }

  @reload %RadiusApi.Devices.NasReload{
    reload_time: @time,
    nas_ip_address: "1.1.1.1"

  }

  @reload_data %{
    reload_time: @time,
    nas_ip_address: "1.1.1.1"
  }

  test "index/1" do
    assert %{data: [@data]} == RadiusApiWeb.NasJSON.index(%{nas: [@nas]})
  end

  test "show/1" do
    assert %{data: @data} == RadiusApiWeb.NasJSON.show(%{nas: @nas})
  end

  test "reload/1" do
    assert %{data: @reload_data } == RadiusApiWeb.NasJSON.reload(%{reload: @reload})

  end
end

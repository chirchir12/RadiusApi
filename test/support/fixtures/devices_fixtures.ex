defmodule RadiusApi.DevicesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RadiusApi.Devices` context.
  """

  @doc """
  Generate a nas.
  """
  def nas_fixture(attrs \\ %{}) do
    {:ok, nas} =
      attrs
      |> Enum.into(%{
        community: "some community",
        description: "some description",
        nasname: "5.5.5.5",
        ports: 34,
        secret: "secret",
        server: "192.1.1.1",
        type: "other",
        shortname: "mikrotik"
      })
      |> RadiusApi.Devices.create_nas()

    nas
  end
end

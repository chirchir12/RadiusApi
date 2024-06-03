defmodule RadiusApi.NetworkFixtures do
  @moduledoc """
  this module define test helpers used to add user to a network
  """

  def seed_policies() do
    policies = [
      {"admin", "Mikrotik-Rate-Limit", ":=", "100M/100M"},
      {"admin", "Session-Timeout", ":=", "604800"},
      {"guest", "Mikrotik-Rate-Limit", ":=", "10M/10M"},
      {"guest", "Session-Timeout", ":=", "3600"}
    ]

    Enum.each(policies, fn {group_name, attribute, op, value} ->
      RadiusApi.Policies.create_group_check!(%{
        group_name: group_name,
        attribute: attribute,
        op: op,
        value: value
      })

      RadiusApi.Policies.create_group_reply!(%{
        group_name: group_name,
        attribute: attribute,
        op: op,
        value: value
      })
    end)

    {:ok, "done"}
  end
end

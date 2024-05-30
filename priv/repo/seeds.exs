# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
alias RadiusApi.Policies

policies = [
  # this is maximum speed
  {"admin", "Mikrotik-Rate-Limit", ":=", "100M/100M"},
  # 1 week
  {"admin", "Session-Timeout", ":=", "604800"},
  {"guest", "Mikrotik-Rate-Limit", ":=", "10M/10M"},
  {"guest", "Session-Timeout", ":=", "3600"}
]

Enum.each(policies, fn {group_name, attribute, op, value} ->
  Policies.create_group_check!(%{
    group_name: group_name,
    attribute: attribute,
    op: op,
    value: value
  })

  Policies.create_group_reply!(%{
    group_name: group_name,
    attribute: attribute,
    op: op,
    value: value
  })
end)

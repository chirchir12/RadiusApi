defmodule RadiusApi.Repo.Migrations.AddUniqueConstraintOnRadcheck do
  use Ecto.Migration

  def change do
    create_if_not_exists unique_index("radcheck", [:UserName])
    create_if_not_exists unique_index("radusergroup", [:UserName, :GroupName, :priority])
  end
end

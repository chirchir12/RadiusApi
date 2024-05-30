defmodule RadiusApi.Repo.Migrations.UniqueConstraintOnPolicy do
  use Ecto.Migration

  def change do
    create_if_not_exists unique_index("radgroupcheck", [:GroupName, :Attribute, :Value])
    create_if_not_exists unique_index("radgroupreply", [:GroupName, :Attribute, :Value])
  end
end

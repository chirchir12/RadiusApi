defmodule RadiusApi.Repo do
  use Ecto.Repo,
    otp_app: :radiusApi,
    adapter: Ecto.Adapters.Postgres
end

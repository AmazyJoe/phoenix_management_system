defmodule System2.Repo do
  use Ecto.Repo,
    otp_app: :system_2,
    adapter: Ecto.Adapters.Postgres
end

defmodule Nya.Repo do
  use Ecto.Repo,
    otp_app: :nya,
    adapter: Ecto.Adapters.Postgres
end

defmodule Chronoquants.Repo do
  use Ecto.Repo,
    otp_app: :chronoquants,
    adapter: Ecto.Adapters.Postgres
end

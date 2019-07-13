defmodule Biteme.Repo do
  use Ecto.Repo,
    otp_app: :biteme,
    adapter: Ecto.Adapters.Postgres
end

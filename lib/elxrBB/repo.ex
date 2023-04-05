defmodule ElxrBB.Repo do
  use Ecto.Repo,
    otp_app: :elxrBB,
    adapter: Ecto.Adapters.Postgres
end

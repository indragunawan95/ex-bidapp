defmodule Exbidapp.Repo do
  use Ecto.Repo,
    otp_app: :exbidapp,
    adapter: Ecto.Adapters.Postgres
end

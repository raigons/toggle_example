defmodule ToggleExample.Repo do
  use Ecto.Repo,
    otp_app: :toggle_example,
    adapter: Ecto.Adapters.Postgres
end

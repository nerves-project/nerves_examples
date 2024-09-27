defmodule Ui.Repo do
  use Ecto.Repo,
    otp_app: :ui,
    adapter: Ecto.Adapters.SQLite3
end

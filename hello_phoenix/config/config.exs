# This file is responsible for configuring your application and its
# dependencies.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
import Config

# Enable the Nerves integration with Mix
Application.start(:nerves_bootstrap)

config :hello_phoenix,
  ecto_repos: [HelloPhoenix.Repo]

config :hello_phoenix, HelloPhoenix.Repo,
  pool_size: 5,
  show_sensitive_data_on_connection_error: true

# Configures the endpoint
config :hello_phoenix, HelloPhoenixWeb.Endpoint,
  http: [port: 80],
  render_errors: [view: HelloPhoenixWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: HelloPhoenix.PubSub,
  live_view: [signing_salt: "4jVC64mw"]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.15.13",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

if Mix.target() == :host do
  import_config "host.exs"
else
  import_config "target.exs"
end

if File.exists?("config/#{Mix.env()}.exs") do
  import_config "#{Mix.env()}.exs"
end

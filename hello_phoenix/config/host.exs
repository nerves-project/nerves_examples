import Config

# Add configuration that is only needed when running on the host here.

config :hello_phoenix, HelloPhoenix.Repo,
  database: Path.expand("../tmp/ui_dev.db", Path.dirname(__ENV__.file)),
  pool_size: 5,
  show_sensitive_data_on_connection_error: true

# Configures the endpoint
config :hello_phoenix, HelloPhoenixWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {127, 0, 0, 1}, port: 4000],
  url: [host: "localhost"],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "JJSA+DNgIaLuKEV4SopRwuwGFOHOD4IqGVJQXUqZSmhYCK/QlOxn/Gyu91O/JRvp",
  watchers: [
    # Start the esbuild watcher by calling Esbuild.install_and_run(:default, args)
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]}
  ]

# Watch static and templates for browser reloading.
config :hello_phoenix, HelloPhoenixWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/hello_phoenix_web/(live|views)/.*(ex)$",
      ~r"lib/hello_phoenix_web/templates/.*(eex)$"
    ]
  ]

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

# Configure esbuild (the version is required)
# config :esbuild,
#   version: "0.15.13",
#   default: [
#     args:
#       ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
#     cd: Path.expand("../assets", __DIR__),
#     env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
#   ]

# Overrides for host and unit tests:
#
# * udhcpc_handler: capture whatever happens with udhcpc
# * udhcpd_handler: capture whatever happens with udhcpd
# * interface_renamer: capture interfaces that get renamed
# * resolvconf: don't update the real resolv.conf
# * path: limit search for tools to our test harness
# * persistence_dir: use the current directory
# * power_managers: register a manager for test0 so that tests
#      that need to validate power management calls can use it.
config :vintage_net,
  udhcpc_handler: VintageNetTest.CapturingUdhcpcHandler,
  udhcpd_handler: VintageNetTest.CapturingUdhcpdHandler,
  interface_renamer: VintageNetTest.CapturingInterfaceRenamer,
  resolvconf: "/dev/null",
  path: "#{File.cwd!()}/test/fixtures/root/bin",
  persistence_dir: "./test_tmp/persistence"

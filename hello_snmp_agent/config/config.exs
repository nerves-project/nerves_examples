# This file is responsible for configuring your application and its
# dependencies.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
import Config

# Enable the Nerves integration with Mix
Application.start(:nerves_bootstrap)

config :hello_snmp_agent, target: Mix.target()

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Set the SOURCE_DATE_EPOCH date for reproducible builds.
# See https://reproducible-builds.org/docs/source-date-epoch/ for more information

config :nerves, source_date_epoch: "1634820789"

# Use Ringlogger as the logger backend and remove :console.
# See https://hexdocs.pm/ring_logger/readme.html for more information on
# configuring ring_logger.

config :logger, backends: [RingLogger]

config :hello_snmp_agent, HelloSnmpAgent.Agent,
  dir: './priv/',
  versions: [:v1, :v2, :v3],
  port: "SNMP_PORT" |> System.get_env("161") |> String.to_integer(),
  transports: ["127.0.0.1"],
  security: [
    [user: "public", password: "password", access: :public],
    [user: "admin", password: "adminpassword", access: [:public, :secure]]
  ]

if Mix.target() == :host do
  import_config "host.exs"
else
  import_config "target.exs"
end

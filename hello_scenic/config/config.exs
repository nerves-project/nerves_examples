# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
import Config

# connect the app's asset module to Scenic
config :scenic, :assets, module: HelloScenic.Assets

# Configure the main viewport for the Scenic application
config :hello_scenic, :viewport, %{
  name: :main_viewport,
  size: {320, 240},
  theme: :dark,
  default_scene: HelloScenic.Scene.Home,
  drivers: [
    [
      module: Scenic.Driver.Local,
      name: :local,
      window: [resizeable: false, title: "hello_scenic"],
      on_close: :stop_system
    ]
  ]
}

# Enable the Nerves integration with Mix
Application.start(:nerves_bootstrap)

config :hello_scenic, target: Mix.target()

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Set the SOURCE_DATE_EPOCH date for reproducible builds.
# See https://reproducible-builds.org/docs/source-date-epoch/ for more information

config :nerves, source_date_epoch: "1695093928"

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "prod.exs"

if Mix.target() == :host do
  import_config "host.exs"
else
  import_config "target.exs"
end

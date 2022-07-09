# This file is responsible for configuring your application and its
# dependencies.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
import Config

# Enable the Nerves integration with Mix
Application.start(:nerves_bootstrap)

config :minimal, target: Mix.target()

# Set the SOURCE_DATE_EPOCH date for reproducible builds.
# See https://reproducible-builds.org/docs/source-date-epoch/ for more information

config :nerves, source_date_epoch: "1578177235"

if Mix.target() == :host do
  import_config "host.exs"
else
  import_config "target.exs"
end

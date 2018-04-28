# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Customize the firmware. Uncomment all or parts of the following
# to add files to the root filesystem or modify the firmware
# archive.

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"
#   fwup_conf: "config/fwup.conf"

config :logger, level: :debug

config :shoehorn,
  init: [:nerves_runtime, :nerves_init_gadget],
  app: Mix.Project.config()[:app]

# Allows over the air updates via SSH.
config :nerves_firmware_ssh,
  authorized_keys: [
    File.read!(Path.join(System.user_home!(), ".ssh/id_rsa.pub"))
  ]

# Allows for tailing of logs.
config :logger, backends: [RingLogger]

# Set a mdns domain and node_name to be able to remsh into the device.
config :nerves_init_gadget,
  node_name: :blinky,
  mdns_domain: "blinky.local"

# for Devices that don't support usb gadget such as raspberry pi 1, 2, and 3.
# address_method: :dhcp,
# ifname: "eth0"

# Import target specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Uncomment to use target specific configurations

import_config "#{Mix.Project.config()[:target]}.exs"

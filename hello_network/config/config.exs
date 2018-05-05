# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :logger, level: :debug

# Uncomment the following line for the interface you intend to use,
# if not the wired :eth0 interface.
config :hello_network, interface: :eth0
# config :hello_network, interface: :wlan0
# config :hello_network, interface: :usb0

key_mgmt = System.get_env("NERVES_NETWORK_KEY_MGMT") || "WPA-PSK"

config :nerves_network, :default,
  wlan0: [
    ssid: System.get_env("NERVES_NETWORK_SSID"),
    psk: System.get_env("NERVES_NETWORK_PSK"),
    key_mgmt: String.to_atom(key_mgmt)
  ],
  eth0: [
    ipv4_address_method: :dhcp
  ]

# Customize the firmware. Uncomment all or parts of the following
# to add files to the root filesystem or modify the firmware archive.
# Make sure you have a comma between each of the options under each `config`
# stanza.

config :nerves, :firmware,
  rootfs_overlay: "rootfs_overlay"
#  fwup_conf: "config/fwup.conf"

# Use shoehorn to start the main application. See the shoehorn
# docs for separating out critical OTP applications such as those
# involved with firmware updates.
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
  node_name: :hello_network,
  mdns_domain: "hello_network.local"

# For Devices that don't support USB gadget mode (such as Raspberry Pi 3),
# you may want to change the primary network interface or IP address method:
#
#config :nerves_init_gadget,
#  address_method: :dhcp,
#  ifname: "eth0"

# Import target specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Uncomment to use target specific configurations

# import_config "#{Mix.Project.config[:target]}.exs"

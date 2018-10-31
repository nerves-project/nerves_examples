# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Configure nerves_init_gadget for the interface you intend to use
# See https://hexdocs.pm/nerves_init_gadget/readme.html for more information.

# Set a mdns domain and node_name to be able to remsh into the device.
config :nerves_init_gadget,
  node_name: :hello_network,
  mdns_domain: "hello_network.local",
  address_method: :dhcp,
  ifname: "eth0"
  # ifname: "wlan0"

  # To use USB gadget mode on supported devices:
  # ifname: "usb0",
  # address_method: :dhcpd

# Configure wireless settings

key_mgmt = System.get_env("NERVES_NETWORK_KEY_MGMT") || "WPA-PSK"

config :nerves_network, :default,
  wlan0: [
    ssid: System.get_env("NERVES_NETWORK_SSID"),
    psk: System.get_env("NERVES_NETWORK_PSK"),
    key_mgmt: String.to_atom(key_mgmt)
  ]

# Use shoehorn to start the main application. See the shoehorn
# docs for separating out critical OTP applications such as those
# involved with firmware updates.

config :shoehorn,
  init: [:nerves_runtime, :nerves_init_gadget],
  app: Mix.Project.config()[:app]

# Use Ringlogger as the logger backend and remove :console.
# See https://hexdocs.pm/ring_logger/readme.html for more information on
# configuring ring_logger.

config :logger, backends: [RingLogger]

# Authorize the device to receive firmware using your public key.
# See https://hexdocs.pm/nerves_firmware_ssh/readme.html for more information
# on configuring nerves_firmware_ssh.

key = Path.join(System.user_home!(), ".ssh/id_rsa.pub")
unless File.exists?(key), do: Mix.raise("No SSH Keys found. Please generate an ssh key")

config :nerves_firmware_ssh,
  authorized_keys: [
    File.read!(key)
  ]

# Import target specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Uncomment to use target specific configurations

# import_config "#{Mix.Project.config[:target]}.exs"

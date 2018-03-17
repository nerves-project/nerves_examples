# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Customize the firmware. Uncomment all or parts of the following
# to add files to the root filesystem or modify the firmware
# archive.

config :nerves, :firmware,
  rootfs_overlay: "rootfs_overlay"
#   fwup_conf: "config/fwup.conf"

config :logger, level: :debug

# NOTE: The nerves_neopixel library currently only supports
# Raspberry Pi. The Raspberry Pi only has the following two
# IO pins that support hardware PWM, which is required to
# drive NeoPixels.

config :neopixel, :channel0,
  pin: 18,
  count: 36

config :neopixel, :channel1,
  pin: 19,
  count: 21

# Use shoehorn to start the main application. See the shoehorn
# docs for separating out critical OTP applications such as those
# involved with firmware updates.
config :shoehorn,
  init: [:nerves_runtime],
  app: Mix.Project.config()[:app]

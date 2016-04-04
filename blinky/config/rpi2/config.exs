# Configuration for the Raspberry Pi 2 Model B (target rpi2)
use Mix.Config
import_config "../config.exs"

config :nerves_io_led, names: [ red: "led0", green: "led1" ]

# Configuration for the Raspberry Pi A+ / B+ / B / Zero (target rpi)
use Mix.Config
import_config "../config.exs"

config :nerves_io_led, names: [ red: "led0", green: "led1" ]

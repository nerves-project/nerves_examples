# Configuration for the Raspberry Pi 4 (target rpi4)
import Config

config :blinky, led_list: [:green]
config :nerves_leds, names: [green: "led0"]

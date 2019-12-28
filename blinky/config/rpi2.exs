# Configuration for the Raspberry Pi 2 Model B (target rpi2)
import Config

config :blinky, led_list: [:green]
config :nerves_leds, names: [green: "led0"]

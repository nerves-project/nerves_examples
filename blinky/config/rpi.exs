# Configuration for the Raspberry Pi A+ / B+ / B / Zero (target rpi)
import Config

config :blinky, led_list: [:green]
config :nerves_leds, names: [green: "led0"]

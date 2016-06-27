# configuration for PC Engines Alix 2d/3d series (target alix)
use Mix.Config

config :blinky, led_list: [ :led1, :led2, :led3 ]

config :nerves_leds, names: [
  led1: "alix:1",
  led2: "alix:2",
  led3: "alix:3"
]

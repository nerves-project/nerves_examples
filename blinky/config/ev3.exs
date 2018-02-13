# Configuration for the Lego Mindstorms EV3 brick (target ev3)
use Mix.Config

config :blinky, led_list: [:led0, :led1, :led2, :led3]

config :nerves_leds,
  names: [
    led0: "ev3:left:green:ev3dev",
    led1: "ev3:right:green:ev3dev",
    led2: "ev3:left:red:ev3dev",
    led3: "ev3:right:red:ev3dev"
  ]

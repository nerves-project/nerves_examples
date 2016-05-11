use Mix.Config

# this default configuration is appropriate for the raspberry pi
# it is overridden by custom target configuration brought below

config :blinky, led_list: [ :red, :green ]
config :nerves_io_led, names: [ red: "led0", green: "led1" ]

import_config "#{Mix.Project.config[:target]}.exs"

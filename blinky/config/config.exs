use Mix.Config

# this default configuration is appropriate for the raspberry pi
# it is overridden by custom target configuration brought below

config :blinky, led_list: [ :red, :green ]
config :nerves_io_led, names: [ red: "led0", green: "led1" ]

# Import custom configuration for each type of target device, which
# will override any similar configuration defined above.

case System.get_env("NERVES_TARGET") do
  nil -> nil
  target -> import_config "target/#{target}.exs"
end
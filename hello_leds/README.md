# `hello_leds`

Functionaly similar to `blinky`, using the Linux leds class instead of manually asserting the GPIO line.

- Boots to Elixir shell and blinks LEDs forever in background
- Uses `Nerves.LED to manage named LEDs
- Custom per-target configuration via `config/#{target}.exs`
- Builds off-target with debug output via `Logger`

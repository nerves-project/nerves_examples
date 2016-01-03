# `blinky`

"Hello World" for the embedded world... and a little more

- Boots to Elixir shell and blinks LEDs forever in background
- Uses `Nerves.LED` to manage named LEDs
- Custom per-target configuration via `config/config.exs`
- Builds off-target with debug output via `Logger`
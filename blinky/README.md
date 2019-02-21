# Blinky

The "Hello World" of the embedded world... blinking an LED

* Boots to Elixir `iex` shell and blinks LEDs forever in background
* Uses `Nerves.Leds` to manage named LEDs
* Custom per-target configuration via `config/#{target}.exs`

## Hardware

No additional hardware is required for this example.
The built-in user-controllable LEDs will blink, as configured for your target hardware.

## How to Use the Code in this Repository

1. Specify your target with the `MIX_TARGET` environment variable
2. Get dependencies with `mix deps.get`
3. Create firmware with `mix firmware`
4. Burn firmware to an SD card with `mix firmware.burn`
5. Insert the SD card into your target board and power it on
6. After about 10-30 seconds, the configured LED(s) should start blinking every 200ms
  a. Note: during the boot process the LED may blink sporadically

```bash
export MIX_TARGET=rpi0
mix deps.get
mix firmware
mix firmware.burn
```

## Learn More

* Official docs: https://hexdocs.pm/nerves/getting-started.html
* Official website: https://nerves-project.org/
* Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
* Source: https://github.com/nerves-project/nerves

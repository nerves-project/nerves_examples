# Hello LEDs

Functionally similar to `blinky`, but showing how the [Linux `/sys/class/leds` interface](http://elixir.free-electrons.com/source/Documentation/leds/leds-class.txt?v=4.10) can be used to blink the LED(s) instead of manually turning them on and off.

- Boots to Elixir shell and blinks LEDs forever in background
- Uses `Nerves.Leds` to manage named LEDs
- Custom per-target configuration via `config/#{target}.exs`

## Hardware

No additional hardware is required for this example.
The built-in user-controllable LEDs will blink, as configured for your target hardware.

## How to use the code in the repository

1. Specify your target with the `MIX_TARGET` environment variable
2. Get dependencies with `mix deps.get`
3. Create firmware with `mix firmware`
4. Burn firmware to an SD card with `mix firmware.burn`
5. Insert the SD card into your target board and power it on
6. After about 5 seconds, the configured LED(s) should start blinking

``` bash
export MIX_TARGET=rpi3
mix deps.get
mix firmware
mix firmware.burn
```

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: http://www.nerves-project.org/
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves


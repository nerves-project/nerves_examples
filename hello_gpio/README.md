# Hello GPIO

This example demonstrates how to control General Purpose Input/Output (GPIO) pins using the `elixir_ale` library.

## Hardware

You will need a singe LED connected to GND and a GPIO pin with a 270 Ω resistor.

![GPIO schematic](assets/gpio.png)

The default configuration uses GPIO pin 26, which can be found on a Raspberry Pi using the following diagram from https://pinout.xyz:

![Raspberry Pi pinout](https://pinout.xyz/resources/raspberry-pi-pinout.png)

## How to use the code in the repository

1. Connect the hardware according to the schematic above
2. Configure which output pin to use by editing `config\config.exs`
3. Get dependencies with `mix deps.get`
4. Create firmware with `mix firmware`
5. Burn firmware to an SD card with `mix firmware.burn`
6. Insert the SD card into your target board and power it on
7. After about 5 seconds, the LED should start blinking

The default target is set to Raspberry Pi 3.
If you are creating an image for any other target, either change the default in `mix.exs` or preface all mix commands with a `NERVES_TARGET` environment variable.
For example, if you're using a BeagleBone Black:

``` bash
NERVES_TARGET=bbb mix deps.get
NERVES_TARGET=bbb mix firmware
NERVES_TARGET=bbb mix firmware.burn
```

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: http://www.nerves-project.org/
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves

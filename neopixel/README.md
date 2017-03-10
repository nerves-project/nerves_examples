# NeoPixel

Control [WS2812 "NeoPixel" RGB LEDs](https://www.adafruit.com/category/168) directly from a Raspberry Pi.
This example only works on the Raspberry Pi family of targets because the `nerves_neopixel` library currently only supports the Pulse-Width Modulation (PWM) hardware built into the Raspberry Pi.

## Hardware

Driving NeoPixels can be a little tricky at first because of their unusual protocol and power requirements.
Most importantly, they are designed to use a 5V supply for both power and data, whereas the Raspberry Pi only offers 3.3V I/O pins.

You will need to use a level-shifter chip to convert the 3.3V signals from the Raspberry Pi to 5V signals compatible with the NeoPixels.
It is **highly recommended** that you take a look at [Adafruit's NeoPixel guide](https://learn.adafruit.com/adafruit-neopixel-uberguide/overview) before proceeding.
You can permanently damage your NeoPixels or your Raspberry Pi if you connect them wrong.
Even if you don't damage anything, you are more likely to be disappointed or frustrated if you don't take a look at the guide first.

## How to Use this Repository

1. Connect the hardware according to the guide mentioned above
2. Configure which PWM pin to use by editing `config/config.exs`
3. Specify your target with the `MIX_TARGET` environment variable
4. Get dependencies with `mix deps.get`
5. Create firmware with `mix firmware`
6. Burn firmware to an SD card with `mix firmware.burn`
7. Connect a monitor to the HDMI port on the board
8. Insert the SD card into your target board and power it on
9. After it finishes booting (about 5 seconds), an animated pattern should start moving down your strip of NeoPixels

``` bash
MIX_TARGET=rpi3
mix deps.get
mix firmware
mix firmware.burn
```

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: http://www.nerves-project.org/
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves

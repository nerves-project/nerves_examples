# Hello GPIO

This example demonstrates how to use General-Purpose Input/Output (GPIO) pins as
digital inputs and outputs using the [`circuits_gpio`
library](https://github.com/elixir-circuits/circuits_gpio).  The example uses two separate
circuits. The first circuit contains an LED that is turned on and off by Elixir
controlling a GPIO pin. In the second circuit, Elixir monitors a GPIO pin and
logs the changing state of a manual switch.

## Hardware

For the output pin, you will need a single LED connected to GND and a GPIO pin
with a 270 Ω resistor. For the input pin, connect a 4-pin push-button with a 10
kΩ pull-up resistor to a GPIO pin.

![GPIO schematic](assets/gpio.png)
![GPIO_schematic](assets/GPIO-input.png)

The default configuration uses GPIO BCM pin 26 for output and GPIO BCM pin 20
for input.  Note that you are using the labeled BCM pins as found on a Raspberry
Pi as shown in the diagram at [pinout.xyz](https://pinout.xyz).

![Raspberry Pi pinout](https://pinout.xyz/resources/raspberry-pi-pinout.png)

## How to Use the Code in this Repository

1. Connect the hardware according to the schematic above
2. Configure which pins to use to use by editing `config/config.exs`
3. Specify your target with the `MIX_TARGET` environment variable
4. Get dependencies with `mix deps.get`
5. Create firmware with `mix firmware`
6. Burn firmware to an SD card with `mix firmware.burn`
7. Connect a monitor to the HDMI port on the board
8. Insert the SD card into your target board and power it on
9. After about 5 seconds, the LED should start blinking
10. Enter `RingLogger.attach` at the IEx prompt in the console
11. On the monitor you will see log entries showing the status of the LED.
    Pressing the switch button will display entries showing the changing state
    of the switch

```bash
export MIX_TARGET=rpi3
mix deps.get
mix firmware
mix firmware.burn
```

## Learn More

* Official docs: https://hexdocs.pm/nerves/getting-started.html
* Official website: https://nerves-project.org/
* Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
* Source: https://github.com/nerves-project/nerves

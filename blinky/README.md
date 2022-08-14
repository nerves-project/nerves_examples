# Blinky

The "Hello World" of the embedded world... blinking an LED

* Boots to Elixir `iex` shell and blinks LEDs forever in background
* Uses [Delux](https://hexdocs.pm/delux/readme.html) to control the LEDs
* Custom per-[target] configuration via `config/#{target}.exs`

## Hardware

This example controls the built-in user-controllable LEDs on your target
hardware so no additional hardware is needed.

## Description

If you've used an Arduino or Raspberry Pi Pico, you're probably expecting to see
code that loops between turning an LED on, waiting, and then turning it off.
This example doesn't do that. Instead, it tells the Delux library what it wants
the LED to do, and Delux figures out what to tell the Linux kernel to do to make
it happen. This results in an efficient way of controlling LEDs where Elixir
code decides what should happen, but the actual timing happens at a low level.

This demo has two parts: board-specific LED configuration and initialization of
Delux to blink at 2 Hz.

Configuration of each supported board is in `config/<target>.exs`. For example,
the Raspberry Pi Zero's configuration looks like:

```elixir
config :blinky,
  indicators: %{
    default: %{
      green: "led0"
    }
  }
```

This provides configuration for the demo application, `:blinky`. The atom
`:indicators` is used by Delux to group LEDs that are controlled together. The
Normally this would be a red, green, and blue LED, but the Raspberry Pi just has
a green LED. For convenience, we tell Delux that the `:default` indicator has a
`:green` LED. It's known to Linux as `"led0"`. You can find the names by listing
the `/sys/class/leds` directory.

The second part of the demo is to add `Delux` to this project's supervision
tree. This happens in `Blinky.Application` and looks like:

```elixir
    children = [
      {Delux, delux_options ++ [initial: Delux.Effects.blink(:on, 2)]}
    ]

    opts = [strategy: :one_for_one, name: Blinky.Supervisor]
    Supervisor.start_link(children, opts)
```

This code passes the options defined in the configuration and adds an initial
program for the LEDs. In this case, it specifies that all LEDs on the default
indicator should be blinked at 2 Hz.

The `Delux.Effects` module provides lots of helper functions for creating LED
programs. You can explore these at the IEx prompt like this:

```elixir
iex> Delux.render(Delux.Effects.blink(:green, 0.5))
:ok
```

## How to Use the Code in this Repository

1. Specify your [target] with the `MIX_TARGET` environment variable
2. Get dependencies with `mix deps.get`
3. Create firmware with `mix firmware`
4. Burn firmware to an SD card with `mix firmware.burn`
5. Insert the SD card into your target board and power it on
6. After about 10-30 seconds, the configured LED(s) should start blinking at 2 Hz
  a. Note: If the device normally blinks an LED to show a heartbeat or other status, you'll see that during the boot process until Delux takes over.

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

[target]: https://hexdocs.pm/nerves/targets.html

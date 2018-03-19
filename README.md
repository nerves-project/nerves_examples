# Nerves Examples

[![CircleCI](https://circleci.com/gh/nerves-project/nerves_examples.svg?style=svg)](https://circleci.com/gh/nerves-project/nerves_examples)

This repository contains example projects for getting started with
[Nerves](http://nerves-project.org).

To try these out, you'll need to work through the [Nerves installation
instructions](https://hexdocs.pm/nerves/installation.html#content) and get some
hardware. We recommend starting with a Raspberry Pi or a BeagleBone. See the
[Nerves supported targets](https://hexdocs.pm/nerves/targets.html) for options.

## WARNING

All of the examples in this repository require a 1.0.0 release candidate
version of the `nerves_bootstrap` archive to build. Hex.pm installs earlier
versions by default, so make sure to upgrade by running:

```bash
mix archive.install hex nerves_bootstrap "~> 1.0-rc"
```

Don't give up! If something doesn't work right, we're probably missing
something.  Let us know by filing an
[issue](https://github.com/nerves-project/nerves_examples/issues) or sending a
pull request. You can find us on the [elixir-lang Slack's #nerves
channel](https://elixir-slackin.herokuapp.com/) and on the [Elixir
Forum](https://elixirforum.com/c/dedicated-sections/nerves).

## blinky

Blink an LED! This is the "Hello, world!" of embedded programming.

Recommended platforms: All Raspberry Pis and Beaglebones

[More information](blinky/README.md)

## hello_gpio

Toggle a GPIO using [elixir_ale](https://hex.pm/packages/elixir_ale). Once you
have this project working, check out `elixir_ale` for communicating with I2C and
SPI devices and [nerves_uart](https://hex.pm/packages/nerves_uart) for
communicating through serial ports and UARTs.

Recommended platforms: All Raspberry Pis

[More information](hello_gpio/README.md)

## hello_leds

Even though LEDs can be controlled via GPIO, they have special support in the
Linux kernel to make blinking them or triggering them based on I/O events.

Recommended platforms: All platforms

* [`hello_leds`](hello_leds/README.md)

## hello_network

Nerves is very minimal and doesn't configure networking by default. This example
shows one way of getting started.

Recommended platforms: all

* [`hello_network`](hello_network/README.md)

## hello_phoenix

Set up Phoenix on your device so that you can control it via a web browser.

Recommended platforms: all

[More information](hello_phoenix/README.md)

## neopixel

* [`neopixel`](neopixel/README.md)

## More

Looking for more examples? Try searching [hex.pm](https://hex.pm) for the
hardware that you want to use and see if it has examples. Have an idea for an
example? File an issue and point us to an example repository.

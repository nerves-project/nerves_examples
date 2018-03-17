Nerves Examples
===============
[![CircleCI](https://circleci.com/gh/nerves-project/nerves_examples.svg?style=svg)](https://circleci.com/gh/nerves-project/nerves_examples)

# WARNING
All of the examples in this repository require the 1.0.0 release candidate
version of the `nerves_bootstrap` archive. Install it with

```bash
mix archive.install hex nerves_bootstrap 1.0.0-rc.2
```

This repository contains several Nerves example projects as sub-directories.
Most of these projects should work on all of the [Nerves supported targets](https://hexdocs.pm/nerves/targets.html).
One notable exception is the `neopixel` example, which depends on the Raspberry Pi hardware and won't work on other platforms.

For detailed information on how to build an example, see the `README.md` in each application's root directory.

* [`blinky`](https://github.com/nerves-project/nerves-examples/blob/master/blinky/README.md)
* [`hello_gpio`](https://github.com/nerves-project/nerves-examples/blob/master/hello_gpio/README.md)
* [`hello_leds`](https://github.com/nerves-project/nerves-examples/blob/master/hello_leds/README.md)
* [`neopixel`](https://github.com/nerves-project/nerves-examples/blob/master/neopixel/README.md)
* [`hello_network`](https://github.com/nerves-project/nerves-examples/blob/master/hello_network/README.md)
* [`hello_phoenix`](https://github.com/nerves-project/nerves-examples/blob/master/hello_phoenix/README.md)

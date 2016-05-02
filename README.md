Nerves Examples
===============

[![Build Status](https://travis-ci.org/nerves-project/nerves-examples.png?branch=master)](https://travis-ci.org/nerves-project/nerves-examples)

Here are couple simple nerves examples.   All of these projects should work on the following platforms:

- Raspberry Pi A+/B+
- Raspberry Pi 2 B
- Raspberry Pi Zero
- Beaglebone Black

For detailed information on how to build an example, see the README.md in each application's root directory.

### `blinky`

"Hello World" for the embedded world... and a little more

- Boots to Elixir shell and blinks LEDs forever in background
- Uses `Nerves.LED` to manage named LEDs
- Custom per-target configuration via `config/config.exs`
- Builds off-target with debug output via `Logger`

### `hello_network`

Brings up network, makes it discoverable

- Uses `Nerves.Networking` to configure DHCP with ipv4LL fallback
- Demonstrates using `Nerves.SSDP.Server` for discovery via `cell list`

## Configuring Build Environment

The examples currently support Raspberry Pi (rpi), Raspberry Pi 2 (rpi2), and Beaglebone Black (bbb) targets.

The following instructions assume rpi2, but you can substitute any of the supported target IDs below.

On OS X:

```
brew update
brew upgrade elixir   ## v1.2.4, BUT NOT HEAD!!
brew install coreutils
```

On All Platforms:

```
mix local.hex # update hex
mix archive.install https://github.com/nerves-project/archives/raw/master/nerves_bootstrap.ez —force
```

## Building with Mix

Note that `NERVES_TARGET` environment can set the platform you get.  See mix.exs
for the example to see how this works.

```
cd <example-project>
git pull
git checkout mix
rm -rf rel _images _build
mix deps.clean --all
mix deps.get
mix firmware
```

## Burning Using Mix

For Mac OS
```
$ mix firmware.burn
```

## Burning with `fwup`

```
$ fwup -a -i _images/rpi2/blinky.fw -t complete
```

Nerves Examples
===============

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

### Building using Bake

See the [bakeware web site](http://bakeware.io) for bake install instructions.

```
cd <example-project>
bake system get --target rpi2
bake toolchain get --target rpi2
bake firmware --target rpi2
```

## Compiling & Burning

```sh
$ bake firmware --target rpi2
```

For Mac OS
```
$ bake burn --target rpi2
```

For Linux (shown using the blinky app, you will need to replace this with the name of the otp app and target name you are trying to burn)
```
$ fwup -a -i _images/blinky-rpi2 -t complete
```

### Switching targets

You can change targets by passing a different `--target` to the command line options for the bake commands. You can also set the default target globally. This makes it a little easier for people who will be typically deploying firmware for a certain board. Lets say you own a BeagleBone Black and you always want to have `bake` assume you want to build for that.

```
$ bake global set default_target bbb
```

Now that you have a global target defined, you can omit the `--target` flag

```
$ bake firmware
=> Using global default target: bbb
```

You can also get or clear this value

```
$ bake global get default_target
=> Global variable default_target: rpi2
$ bake global clear default_target
$ bake global get default_target
=> Global variable default_target is not set
```

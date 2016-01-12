Nerves Examples
===============

Here are couple simple nerves examples.   All of these projects should work on the following platforms:

- Raspberry Pi B+
- Raspberry Pi model 2 B
- Beaglebone Black

For detailed information on how to build an example, see the README.md in each application's root directory.

### `blinky`

"Hello World" for the embedded world... and a little more

- Boots to Elixir shell and blinks LEDs forever in background
- Uses `Nerves.LED` to manage named LEDs
- Custom per-target configuration via `config/config.exs`
- Builds off-target with debug output via `Logger`

### `hello_ethernet`

Brings up the Ethernet adapter and logs some data through it

- Uses `Nerves.IO.Ethernet` to configure DHCP with ipv4LL fallback

## Configuring Build Environment

The examples currently support Raspberry Pi (rpi), Raspberry Pi 2 (rpi2), and Beaglebone Black (bbb) targets.

The following instructions assume rpi2, but you can substitute any of the supported target IDs below.

### Building using Bake (newer, experimental, recomended)

See the [bakeware web site](http://bakeware.io) for bake install instructions.

```
cd <example-project>
bake system get --target rpi2
bake toolchain get --target rpi2
bake firmware --target rpi2
```

### Building on Mac OS X (homebrew-nerves method)

These instructions currently use [homebrew-nerves](https://github.com/nerves-project/homebrew-nerves).  This may change in the future.

To setup the build environment for the Raspberry Pi 2 on Mac OS X, you can do..

```sh
brew tap nerves-project/nerves
brew nerves get rpi2
cd <example-project>
brew nerves set rpi2        # or your platform
source nerves-env.sh
```

### Building on Linux

Under linux, follow the instructions for [nerves-system-br](https://github.com/nerves-project/nerves-system-br) to build with the appropriate defconfig for your platform and source the resulting nerves-env.sh. 

## Compiling & Burning

```sh
$ NERVES_TARGET=rpi2 make
$ make burn-complete   # burn an sd card
```

### Switching targets

Once you've built a particular target you will have both environment setup for that target and dependencies compiled with that target in mind, so if you want to switch targets, you need to reconfigure both the environment and completely rebuild your project and dependencies.

For instance, to switch targets using the Mac development setup, you would need to setup a new build environment as follows..

```sh
brew nerves get bbb
brew nerves set bbb   # and answer Y to questions about overwrite files
source nerves-env.sh
```
But then, we need to rebuild all dependencies as well..

```sh
$ mix deps.clean --all
$ make clean
$ NERVES_TARGET=bbb make
$ make burn-complete
```

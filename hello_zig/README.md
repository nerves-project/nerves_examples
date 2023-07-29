# Hello Zig

This example demonstrates a basic project for using the `Zigler` library to
write low-level NIFs for a Nerves device.  This project demonstrates
[Zig](https://ziglang.org) code embedded into an Elixir module and how to call
out to a zig code file *external* to the embedded Elixir module.

Notably, no configuration is necessary to get proper cross-compilation between
host and target architectures.

The only thing you need to activate `zigler` is the dependency in your
`mix.exs`:

```elixir
{:zigler, "~> 0.10.1", runtime: false}
```

You might want to use Zig for any of the following things:

* Low-level code that requires interaction with OS syscalls not available
  directly through the BEAM.
* Performance-sensitive code which requires numerical computation
* Wrapping an existing C ABI `.so` or `.a` library.

## Hardware

The example below assumes a Raspberry Pi 3 connected over the Wifi. Other
official and many unofficial Nerves targets work as well. Please post
cross-compilation bug reports to the [zigler issue
tracker](https://github.com/ityonemo/zigler/issues).

## How to use this repository

0. Go to the `hello_zig` directory

1. Set up your build environment

   ```shell
   # Specify the target hardware. See the mix.exs for options
   export MIX_TARGET=rpi3

   # If using WiFi, you can set the SSID and password here
   export NERVES_NETWORK_SSID=your_wifi_name
   export NERVES_NETWORK_PSK=your_wifi_password
   ```

2. Get dependencies, build firmware, and burn it to an SD card

   ```shell
   mix deps.get
   MIX_TARGET=host mix zig.get
   mix firmware
   mix firmware.burn
   ```

3. Insert the SD card into your target board and power up

4. Wait to finish booting.

5. SSH into the board: `ssh nerves.local`

6. Execute `HelloZig.hello()`

7. You should see it output the atom `:world`

## Learn More

- Official docs: https://hexdocs.pm/nerves/getting-started.html
- Official website: https://nerves-project.org/
- Source: https://github.com/nerves-project/nerves

- Zig language docs: https://ziglang.org/
- Zigler docs: https://hexdocs.pm/zigler

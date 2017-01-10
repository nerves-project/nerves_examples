# HelloPhoenix

A basic umbrella app for deploying the Phoenix Framework to Nerves devices.

## Target

The default target is set to `rpi3`

You can change the target by either modifying the `apps/fw/mix.exs` default
```elixir
# mix.exs

@target System.get_env("NERVES_TARGET") || "rpi"
```

or prefix all mix commands with your target. `NERVES_TARGET=rpi mix firmware`

## Network Connection

The project is also configured to use static ethernet so you can plug the cable
directly in to your machine. You can change this behaviour by editing the interface
options in `apps/fw/lib/fw.ex`

To use DHCP
```elixir
@opts [mode: "dhcp"]
```

You can use also run the exmaple with wifi by switching out the `nerves_networking` dependency
for `nerves_interim_wifi`

For more information See

https://github.com/nerves-project/nerves_networking
https://github.com/nerves-project/nerves_interim_wifi

To run the example:
```
$ cd apps/fw
$ mix deps.get
$ mix firmware
$ mix firmware.burn
```

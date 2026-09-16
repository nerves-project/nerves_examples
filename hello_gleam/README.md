# Hello Gleam

This example is a Nerves application written in
[Gleam](https://gleam.run/). It starts a supervised Gleam actor that prints
`Hello from Gleam!` every five seconds.

Nerves tooling uses Elixir's `mix` build tool, but the application callback,
supervisor, and worker in this project are all Gleam code. The
[`mix_gleam`](https://github.com/gleam-lang/mix_gleam) archive integrates the
Gleam compiler into the Mix build.

## Setup

Install [Gleam](https://gleam.run/getting-started/installing/) and make sure the
`gleam` executable is on your `PATH`. Then install the Mix archives:

```sh
mix archive.install hex nerves_bootstrap
mix archive.install hex mix_gleam
```

## Building

Building follows the standard Nerves recipe. For example:

```sh
export MIX_TARGET=rpi0
mix deps.get
mix firmware
```

Burn the firmware to an SD card with `mix firmware.burn`.

To try the application on your development machine without building firmware:

```sh
mix deps.get
mix run --no-halt
```

## Running

Attach to your board's console after it boots. The application prints:

```text
Hello from Gleam!
```

every five seconds. You can also call its public Gleam function from IEx:

```erlang
hello_gleam:greeting().
```

Gleam modules compile to Erlang modules, so Elixir calls them using atom module
names.

To power off when you're done, run:

```erlang
'Elixir.Nerves.Runtime':poweroff().
```

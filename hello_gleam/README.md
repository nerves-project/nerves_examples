# HelloGleam

This demonstrates a simple Nerves project that includes code written in
[Gleam](http://gleam.run).

## Using

Since Gleam is a BEAM language, it works great with Nerves. This example only
includes a trivial "hello" function written in Gleam but it hopefully provides a
good start for you to expand upon.

The Nerves tooling and many Nerves libraries are written in Elixir. Therefore,
this project uses `mix` to build the firmware and the
[`mix_gleam`](https://hex.pm/mix_gleam) package for the mix integration.

Please run through the Nerves [Getting
Started](https://hexdocs.pm/nerves/getting-started.html) documentation to
install Elixir and the Nerves tooling. Install `mix_gleam` by running:

```sh
mix archive.install hex mix_gleam
```

After everything is installed, pick your target and run through the standard
Nerves firmware build process as described in the next sections:

## Targets

Nerves applications produce images for hardware targets based on the
`MIX_TARGET` environment variable. If `MIX_TARGET` is unset, `mix` builds an
image that runs on the host (e.g., your laptop). This is useful for executing
logic tests, running utilities, and debugging. Other targets are represented by
a short name like `rpi3` that maps to a Nerves system image for that platform.
All of this logic is in the generated `mix.exs` and may be customized. For more
information about targets see:

https://hexdocs.pm/nerves/supported-targets.html

## Getting Started

To start your Nerves app:

1. `export MIX_TARGET=my_target` or prefix every command with
    `MIX_TARGET=my_target`. For example, `MIX_TARGET=rpi3`
2. Install dependencies with `mix deps.get`
3. Create firmware with `mix firmware`
4. Burn to an MicroSD card with `mix burn`
5. Insert the MicroSD into the device and turn it on.

Then either connect over the console (UART or HDMI depending on the device) or
`ssh nerves.local`.

Nerves starts an Elixir shell, so the device will boot to an IEx prompt:

```elixir
iex> :hello.greet
"Hello from Gleam!"
```

## Learn more

* Official docs: https://hexdocs.pm/nerves/getting-started.html
* Official website: https://nerves-project.org/
* Forum: https://elixirforum.com/c/nerves-forum
* Elixir Slack #nerves channel: https://elixir-slack.community/
* Elixir Discord #nerves channel: https://discord.gg/elixir
* Source: https://github.com/nerves-project/nerves


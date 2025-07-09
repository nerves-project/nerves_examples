# HelloErlang

This demonstrates a simple Nerves project that's written in Erlang.

## Erlang-izing a Nerves project

Making Nerves support Erlang or more about deleting the Elixir parts that are
added with the new project generator. Currently we only support using Elixir's
`mix` build tool in the top level project, but you should be able to use other
tools like `rebar3` in dependencies.

The following describes what needed to be done after creating a Nerves project
the "normal" Elixir-based way using `mix nerves.new <project_name>`.

The first step is to delete the `lib` and `test` directories and all of the code
inside of them. Didn't that feel good?

The next step is to update the `rel/vm.args.eex` and delete everything that
starts the Elixir shell. Look for `-noshell` and delete from there to the end.

Finally, create a `src` directory and put your Erlang code in there like you
would a normal Erlang project.

## Building

Building follows the standard Nerves recipe. Here's an example:

```sh
export MIX_TARGET=bbb
mix deps.get
mix firmware
```

And then burn an SD card using `mix firmware.burn`.

## Using

The images pull in the standard `nerves_pack` infrastructure for bringing
up networking and other initialization steps. See the `config/config.exs` for
network parameters and other configuration.

## Running

Attach to the console of your board (i.e., RPi3 is HDMI, BBB/RPi0 is USB
gadget). You should see prints from the application. Note that the first boot
takes quite a bit longer than the rest since it initializes the application's
writable filesystem.

To see log messages, run:

```erlang
> 'Elixir.RingLogger':next().
```


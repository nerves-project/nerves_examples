# Nerves Examples

[![CircleCI](https://circleci.com/gh/nerves-project/nerves_examples.svg?style=svg)](https://circleci.com/gh/nerves-project/nerves_examples)

## Setup

Please see the main [Nerves installation
docs](https://hexdocs.pm/nerves/installation.html) if you haven't used Nerves
before.

Nerves can work with quite a few Elixir and Erlang versions, but we recommend
using the following versions for the examples. These are used on our CI and
should be easier for us to support.

* Elixir 1.16.0 or later
* Erlang OTP 26.1.2 or later

See the [EmbeddedElixir post on using
ASDF-VM](https://embedded-elixir.com/post/2017-05-23-using-asdf-vm/)

This repository contains several Nerves example projects as sub-directories.
Most of these projects should work on all of the [Nerves supported
targets](https://hexdocs.pm/nerves/targets.html).

For detailed information on how to build an example, see the `README.md` in each
application's root directory.

* [`blinky`](https://github.com/nerves-project/nerves-examples/blob/main/blinky/README.md)
* [`hello_erlang`](https://github.com/nerves-project/nerves-examples/blob/main/hello_erlang/README.md)
* [`hello_gpio`](https://github.com/nerves-project/nerves-examples/blob/main/hello_gpio/README.md)
* [`hello_lfe`](https://github.com/nerves-project/nerves-examples/blob/main/hello_lfe/README.md)
* [`hello_live_view`](https://github.com/nerves-project/nerves-examples/blob/main/hello_live_view/README.md)
* [`hello_phoenix`](https://github.com/nerves-project/nerves-examples/blob/main/hello_phoenix/README.md)
* [`hello_snmp_agent`](https://github.com/nerves-project/nerves-examples/blob/main/hello_snmp_agent/README.md)
* [`hello_snmp_manager`](https://github.com/nerves-project/nerves-examples/blob/main/hello_snmp_manager/README.md)
* [`hello_sqlite`](https://github.com/nerves-project/nerves-examples/blob/main/hello_sqlite/README.md)
* [`hello_wifi`](https://github.com/nerves-project/nerves-examples/blob/main/hello_wifi/README.md)
* [`hello_zig`](https://github.com/nerves-project/nerves-examples/blob/main/hello_zig/README.md)
* [`minimal`](https://github.com/nerves-project/nerves-examples/blob/main/minimal/README.md)

## Other examples

The Nerves community has additional projects that may be useful. Here are a few:

* [Nerves Livebook](https://github.com/fhunleth/nerves_livebook) -
  Learn Nerves using the new [Elixir Livebook application](https://github.com/elixir-nx/livebook)
* [Elixir Circuits](https://github.com/elixir-circuits/circuits_quickstart) -
  Experiment with hardware I/O with a pre-built firmware image
* [NervesKey Quickstart](https://github.com/nerves-hub/nerves_key_quickstart) -
  Basic provisioning of an IoT authentication device

## Support

If you are having trouble, let us know. The Nerves community can be found on
[Elixir Forum](https://elixirforum.com/c/nerves-forum) and the #nerves channel
on the [Elixir Slack](https://elixir-slackin.herokuapp.com/).

# Hello Phoenix

This example demonstrates a basic poncho project for deploying a [Phoenix
Framework]-based application to a Nerves device. A "poncho project" is similar
to an umbrella project except that it's actually multiple separate-but-related
Elixir apps that use `path` dependencies instead of `in_umbrella` dependencies.
You can read more about the motivations behind this concept on the
embedded-elixir blog post about [Poncho Projects].

## Hardware

This example serves a Phoenix-based web page over the network using the target's
Ethernet interface. By default, it will use DHCP to get an IP address on its
`eth0` interface. For more information about how to configure the network
settings for your environment, including WiFi settings, see the `hello_network`
example.

## How to Use this Repository

1.  Connect your target hardware to your network as described above
2.  Change to the `firmware` app directory:
3.  Specify your target with the `MIX_TARGET` environment variable
4.  Get dependencies with `mix deps.get`
5.  Create firmware with `mix firmware`
6.  Burn firmware to an SD card with `mix firmware.burn`
7.  Connect a monitor to the HDMI port on the board
8.  Insert the SD card into your target board and power it on
9.  After it finishes booting (about 5 seconds), check the console on the
    monitor for messages about an IP address being assigned.
10. Open a browser window on your host computer to `http://<IP address>/`

``` bash
cd firmware
export MIX_TARGET=rpi3
mix deps.get
mix firmware
mix firmware.burn
```

[Phoenix Framework]: http://www.phoenixframework.org/
[Poncho Projects]: http://embedded-elixir.com/post/2017-05-19-poncho-projects/

## Learn More

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: http://www.nerves-project.org/
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves

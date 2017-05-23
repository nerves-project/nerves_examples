# Hello Phoenix

A basic umbrella app for deploying the [Phoenix Framework] application to a Nerves device.

## Hardware

This example serves a Phoenix-based web page over the network using the target's wired Ethernet interface.
In order to verify that it's working, you will need to either connect it to your host computer either directly or through a switch.
Depending on your network configuration, you may want to statically assign the IP address to the Nerves device (and host computer, or use DHCP.

## How to Use this Repository

1. Connect the network as described above
2. Configure you network preferences by editing `apps/fw/lib/fw.ex` if desired
3. Change to the `apps/fw` directory with `cd apps/fw`
4. Specify your target with the `MIX_TARGET` environment variable
5. Get dependencies with `mix deps.get`
6. Create firmware with `mix firmware`
7. Burn firmware to an SD card with `mix firmware.burn`
8. Connect a monitor to the HDMI port on the board
9. Insert the SD card into your target board and power it on
10. After it finishes booting (about 5 seconds), open a browser window on your host computer to `http://<IP address you chose>/`

``` bash
cd apps/fw
export MIX_TARGET=rpi3
mix deps.get
mix firmware
mix firmware.burn
```

### Network Connection

This example is configured to use a static IP address so you can plug an Ethernet cable
directly from the target to your host. You can change this behavior by editing the interface
options in `apps/fw/lib/fw.ex`

To use DHCP:

```elixir
@opts [mode: "dhcp"]
```

### Using Wireless instead of Wired Ethernet

You can use also run the example with WiFi by switching out the `nerves_networking` dependency
for `nerves_interim_wifi`.

For more information, see:

* https://github.com/nerves-project/nerves_networking
* https://github.com/nerves-project/nerves_interim_wifi

[Phoenix Framework](http://www.phoenixframework.org/)

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: http://www.nerves-project.org/
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves


# Hello WiFi

This example shows how to connect your Nerves device to the network using WiFi.
The directions below show how to use the Raspberry Pi 3 with its built in WiFi, but it will also work with a variety of popular USB WiFi dongles on other targets.

## Hardware

If you are using a Raspberry Pi 3, the WiFi hardware is already built-in.
If you're using another board, you will need to connect a supported USB WiFi dongle.

## How to Use this Repository

1. Configure your WiFi settings by editing `config/config.exs` (note: `ssid` is case-sensitive`)

   ```elixir
   # config/config.exs
   use Mix.Config

   config :hello_wifi, :wlan0,
     ssid: "my_accesspoint_name",
     key_mgmt: :"WPA-PSK",
     psk: "secret"

   ```

2. Specify your target with the `MIX_TARGET` environment variable
3. Get dependencies with `mix deps.get`
4. Create firmware with `mix firmware`
5. Burn firmware to an SD card with `mix firmware.burn`
6. Connect a monitor to the HDMI port on the board
7. Insert the SD card into your target board and power it on
8. After it finishes booting (about 5 seconds), pressing the button will log events to the console on the HDMI monitor

``` bash
MIX_TARGET=rpi3
mix deps.get
mix firmware
mix firmware.burn
```

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: http://www.nerves-project.org/
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves


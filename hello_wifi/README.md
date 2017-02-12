# HelloWifi

Connect your Nerves device to the network using Wifi. This example project is configured to default to the Raspberry Pi 3 board with its built in Wifi. You can also use this with a collection of popular wifi dongles.

To use this on your board:
1. Edit the config file and enter your wifi credentials
```elixir
# config/config.exs
use Mix.Config

config :hello_wifi, :wlan0,
  ssid: "my_accesspoint_name",
  key_mgmt: :"WPA-PSK",
  psk: "secret"

```
2. Fetch the dependencies and create firmware
```
$ mix do deps.get, firmware
```
3. Burn to an SD Card
```
$ mix firmware.burn
```


## Learn more

  * Official website: http://www.nerves-project.org/
  * Discussion Slack elixir-lang #nerves
  * Source: https://github.com/nerves-project/nerves

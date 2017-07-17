# Hello Network

## How to use the code in the repository

1. Specify your target with the `MIX_TARGET` environment variable
2. Get dependencies with `mix deps.get`
3. Create firmware with `mix firmware`
4. Burn firmware to an SD card with `mix firmware.burn`
5. Connect a monitor to the HDMI port on the board
6. Insert the SD card into your target board and power it on
7. After about 5 seconds, you should see messages on the console

``` bash
export MIX_TARGET=rpi3
mix deps.get
mix firmware
mix firmware.burn
```

### Testing DNS name resolution

There is a `HelloNetwork.test_dns` function that you can call in the IEx
console to check that your Nerves device indeed has successfully established
network connectivity and that DNS name resolution works. The expected output
when DNS resolution is available is something like this:

``` elixir
iex(1)> HelloNetwork.test_dns()
{:ok,
 {:hostent, 'nerves-project.org', [], :inet, 4,
  [{192, 30, 252, 154}, {192, 30, 252, 153}]}}
```
## Limitations

Supports only [IPv4LL]

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: http://www.nerves-project.org/
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves

[DHCP]:        https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol
[SSDP]:        https://en.wikipedia.org/wiki/Simple_Service_Discovery_Protocol
[`cell-tool`]: https://github.com/nerves-project/cell-tool
[IPv4LL]:      https://en.wikipedia.org/wiki/Zero-configuration_networking#Link-local_IPv4_addresses

# Hello Network

This example shows how to connect your Nerves device to the network using wired
or wireless Ethernet. By default, the configuration assumes that you'll be
connecting using the wired Ethernet interface `eth0`, but you can change the
`:interface` option in `config/config.exs` to choose another interface (such as
`:wlan0` for WiFi or `:usb0` for USB gadget-mode Ethernet). The targets with
built-in WiFi hardware (such as `rpi3` and `rpi0` on a Zero W) will work with
their built in WiFi, but you can also use a variety of popular USB WiFi dongles
on other targets.

## How to Use the Code in this Repository

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

### How to Use the WiFi Interface

Configure the application settings to use your WiFi interface (`:wlan0`) instead
of your wired interface (`:eth0`):

```elixir
# config/config.exs

# ...

#config :hello_network, interface: :eth0
config :hello_network, interface: :wlan0
#config :hello_network, interface: :usb0

key_mgmt = System.get_env("NERVES_NETWORK_KEY_MGMT") || "WPA-PSK"

config :nerves_network, :default,
  wlan0: [
    ssid: System.get_env("NERVES_NETWORK_SSID"),
    psk: System.get_env("NERVES_NETWORK_PSK"),
    key_mgmt: String.to_atom(key_mgmt)
  ],
  eth0: [
    ipv4_address_method: :dhcp
  ]

# ...
```

Specify your WiFi settings using the `NERVES_NETWORK_SSID` and
`NERVES_NETWORK_PSK` environmental variables during the firmware build process:

> Note: `NERVES_NETWORK_SSID` and `NERVES_NETWORK_PSK` are both case-sensitive.

``` bash
export NERVES_NETWORK_SSID=my_accesspoint_name
export NERVES_NETWORK_PSK=secret
export MIX_TARGET=rpi3
mix deps.get
mix firmware
mix firmware.burn
```

### Testing DNS Name Resolution

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

### Distributed tasks and Nerves

The idea was to play around with Nerves and put in practice one of the features
Elixir has out of the box: connecting to other existing VM instances, or "nodes".

Here is the exercise I was completing:
[Our first distributed code](https://elixir-lang.org/getting-started/mix-otp/distributed-tasks-and-configuration.html#our-first-distributed-code)

Here are the steps I took to make the above work using Nerves (RPi3 and ethernet):

1 - Use the boilerplate project here (HelloNetwork):
  https://github.com/nerves-project/nerves_examples/tree/master/hello_network

2 - Make the following edits:

```
  hello_network [master] :> git diff config/config.exs
  diff --git a/hello_network/config/config.exs b/hello_network/config/config.exs
  index 2601e7c..ef69705 100644
  -  mdns_domain: "hello_network.local"
  +  mdns_domain: "hello_network.local", # This needs a comma, I think the formatter removes it :)

  -# address_method: :dhcp,
  -# ifname: "eth0"
  +  address_method: :dhcp,
  +  ifname: "eth0"
```

3 - Continue to follow the steps on the readme for the boilerplate project

``` bash
mix firmware
MIX_TARGET=rpi3 mix firmware.burn
```

4 - Then, thanks to @jschneck, use the following to create a named IEx session with the correct cookie:

``` bash
iex --name host@0.0.0.0 --cookie "y3//+WLM8CI7g082flQzSDrSFI72BPRDi69Z9rYthm0DtiiYHj7ioY46ibAQJ9+i"`
```

Your IEx prompt will look like this:
```
  iex(host@0.0.0.0)1>
```

Then, you can connect to the target node:

```
  iex(host@0.0.0.0)1> Node.connect(:"hello_network@hello_network.local")
  true
```

And verify that you are connected:

``` elixir
  iex(host@0.0.0.0)2> Node.list
  [:"hello_network@hello_network.local"]
```

Then you can have some fun by passing messages between the nodes.

## Notes:

- `hello_network@hello_network.local` comes from the below, in
  [config/config.exs](https://github.com/nerves-project/nerves_examples/blob/master/hello_network/config/config.exs#L49-L52):

```
config :nerves_init_gadget,
  node_name: :hello_network,
  mdns_domain: "hello_network.local",
```

## Learn More

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: http://www.nerves-project.org/
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves

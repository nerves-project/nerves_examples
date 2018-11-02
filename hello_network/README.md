# Hello Network

This example shows how to connect your Nerves device to the network using wired
or wireless Ethernet. By default, the configuration assumes that you'll be
connecting using the wired Ethernet interface `eth0`, but you can change the
`:ifname` option in `config/config.exs` to choose another interface (such as
`"wlan0"` for WiFi or `"usb0"` for USB gadget-mode Ethernet). The targets with
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

Configure the application settings to use your WiFi interface (`"wlan0"`) instead
of your wired interface (`"eth0"`):

```elixir
# config/config.exs

# ...

config :nerves_init_gadget,
  node_name: :hello_network,
  mdns_domain: "hello_network.local",
  address_method: :dhcp,
  # ifname: "eth0"
  ifname: "wlan0"

key_mgmt = System.get_env("NERVES_NETWORK_KEY_MGMT") || "WPA-PSK"

config :nerves_network, :default,
  wlan0: [
    ssid: System.get_env("NERVES_NETWORK_SSID"),
    psk: System.get_env("NERVES_NETWORK_PSK"),
    key_mgmt: String.to_atom(key_mgmt)
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

#### WiFi Troubleshooting Tips

If you cannot get a network connection, but you can get to the IEx prompt, you
can check the interface status:

```elixir
iex> Nerves.Network.status("wlan0")
%{
  domain: "",
  ifname: "wlan0",
  index: 3,
  ipv4_address: "10.0.1.46",
  ipv4_broadcast: "10.0.1.255",
  ipv4_gateway: "10.0.1.1",
  ipv4_subnet_mask: "255.255.255.0",
  ...
  is_up: true,
  ...
}
```

If it does not have an IP address listed or `is_up` is false, that confirms
that your interface is not connecting properly.

An incorrect WiFi password would normally generate a log message like:

```
00:00:21.986 [info]  WiFiManager(wlan0): ignoring event: {:error, :psk, :FAIL}
```

Checking the status would show the `operstate` is down:

```elixir
iex> Nerves.Network.status("wlan0")
%{
  ifname: "wlan0",
  ...
  is_up: true,
  ...
  operstate: :down,
  ...
}
```

To rule out configuration issues, you can try setting up the connection
manually and watch the log messages that get generated.

> *Note*: The `key_mgmt` setting must be an atom. This is done for you when
> using `config.exs`, but you need to be sure to do it yourself when testing
> manually.

```
iex> Nerves.Network.setup("wlan0", [ssid: "Good-Network", psk: "good-pass", key_mgmt: :"WPA-PSK"])
...
00:00:42.132 [info]  Register Nerves.WpaSupplicant "wlan0"
00:00:42.135 [info]  Nerves.WpaSupplicant: sending 'REMOVE_NETWORK all'
00:00:42.148 [info]  Nerves.WpaSupplicant: sending 'ADD_NETWORK'
00:00:42.167 [info]  Nerves.WpaSupplicant: sending 'SET_NETWORK 0 key_mgmt WPA-PSK'
00:00:42.177 [info]  Nerves.WpaSupplicant: sending 'SET_NETWORK 0 psk "goodpass"'
00:00:42.197 [info]  Nerves.WpaSupplicant: sending 'SET_NETWORK 0 ssid "Good-Network"'
00:00:42.353 [info]  Nerves.WpaSupplicant: sending 'SELECT_NETWORK 0'
00:00:43.141 [info]  WiFiManager(wlan0) wpa_supplicant wifi_connected
...
```

If your network isn't hidden, you can try to `scan` and see if you can see it:

```
iex> Nerves.Network.scan("wlan0")
[
  %{
    ...
    ssid: "Good-Network",
    ...
  }
]
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

### Using Erlang Distribution

One of the exciting features that Erlang and Elixir provide out of the box is
called Erlang Distribution. This gives you the ability to easily make a
connection between multiple running instances of the Erlang VM, called "nodes."

Once you have your device running this `nerves_network` example project, you
can use Erlang Distribution to connect to it using from your development host
by starting an `iex` session using the appropriate "cookie" that matches the
one configured on your device:

``` bash
iex --name host@0.0.0.0 --cookie chocolatechip
```

This cookie is set in your project's `rel/vm.args` file, so you can look there
to verify that you have the correct cookie or change the cookie that will be
set in your project's firmware.

Your `iex` prompt should look like this when you are running with distribution:

``` elixir
iex(host@0.0.0.0)1>
```

Then, you can connect to the target node:

``` elixir
iex(host@0.0.0.0)1> Node.connect(:"hello_network@hello_network.local")
true
```

Note that the entire node name is an atom, due to the `:` in front of the
string. You can verify and configure what this node name will be by looking for
the `node_name` and `mdns_domain` settings in your `nerves_init_gadget`
configuration.

``` elixir
# hello_network/config/config.exs

# ...

# Set a mdns domain and node_name to be able to remsh into the device.
config :nerves_init_gadget,
  node_name: :hello_network,
  mdns_domain: "hello_network.local"

# ...
```

There is also a short-cut way to start an `iex` session and automatically
connect to a remote node (split over multiple lines with backslashes just to
make it easier to read):

``` bash
iex --name host@0.0.0.0 \
    --cookie chocolatechip \
    --remsh hello_network@hello_network.local
```

Once connected, you can verify the list of nodes that are connected to the node
running on your host machine.

``` elixir
iex(host@0.0.0.0)2> Node.list
[:"hello_network@hello_network.local"]
```

Then you can have some fun by passing messages between the nodes as described
in [the Elixir documentation][distribution].

[distribution]: https://elixir-lang.org/getting-started/mix-otp/distributed-tasks-and-configuration.html#our-first-distributed-code

## Learn More

* Official docs: https://hexdocs.pm/nerves/getting-started.html
* Official website: http://www.nerves-project.org/
* Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
* Source: https://github.com/nerves-project/nerves

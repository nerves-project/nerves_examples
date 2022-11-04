# Hello Phoenix

This example demonstrates designing and building a firmware with integrated
Phoenix web pages. It is an alternative to "poncho" style projects in that
all code is organized until the same Mix project and designed to be run on
host and on device. In other words, this is a typical Phoenix app most are
used to seeing (with database, contexts, views, etc), but with slightly
altered configuration files and the release step bundles the phoenix app as
part of the firmware.

```
hello_phoenix
├── .formatter.exs
├── .gitignore
├── README.md
├── assets
│   ├── css
│   ├── js
│   └── vendor
├── config
│   ├── config.exs
│   ├── dev.exs
│   ├── host.exs
│   ├── prod.exs
│   ├── runtime.exs
│   ├── target.exs
│   └── test.exs
├── lib
│   ├── hello_phoenix
│   ├── hello_phoenix.ex
│   ├── hello_phoenix_web
│   └── hello_phoenix_web.ex
├── mix.exs
├── mix.lock
├── priv
│   ├── gettext
│   ├── repo
│   └── static
├── rel
│   └── vm.args.eex
└── rootfs_overlay
    └── etc
```

## Hardware

This example serves a Phoenix-based web page over the network. The steps below
assume you are using a Raspberry Pi Zero, which allows you to connect a single
USB cable to the port marked "USB" to get both network and serial console
access to the device. By default, this example will use the virtual Ethernet
interface provided by the USB cable, assign an IP address automatically, and
make it discoverable using mDNS (Bonjour). For more information about how to
configure the network settings for your environment, including WiFi settings,
see the [`vintage_net` documentation](https://hexdocs.pm/vintage_net/).

## How to Use this Repository

### Development

This is designed to run on host as well as firmware. You can use the same
practices as your other Phoenix libs:

```sh
$ iex -S mix phx.server
```

### Building firmware

1. Connect your target hardware to your host computer or network as described
   above

2. Specify your target and other environment variables as needed:

    ```bash
    export MIX_TARGET=rpi0

    # If you're using WiFi:
    #
    #   export NERVES_NETWORK_SSID=your_wifi_name
    #   export NERVES_NETWORK_PSK=your_wifi_password
    ```

3. Get dependencies, build firmware, and burn it to an SD card:

    ```bash
    mix deps.get
    mix firmware
    mix firmware.burn
    ```

4. Insert the SD card into your target board and connect the USB cable or otherwise power it on
5. Wait for it to finish booting (5-10 seconds)
6. Open a browser window on your host computer to `http://nerves.local/`
7. You should see a "Welcome to Phoenix!" page

[Phoenix Framework]: http://www.phoenixframework.org/
[Poncho Projects]: http://embedded-elixir.com/post/2017-05-19-poncho-projects/
[User Interfaces]: https://hexdocs.pm/nerves/user-interfaces.html

## Learn More

* Official docs: https://hexdocs.pm/nerves/getting-started.html
* Official website: https://nerves-project.org/
* Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
* Source: https://github.com/nerves-project/nerves

# hello_gadget

This is an example of using
[nerves_init_gadget](https://github.com/fhunleth/nerves_init_gadget) to
initialize a simple application that runs on a board supporting USB gadget mode.
Currently this is limited to the Raspberry Pi Zero and Raspberry Pi Zero W.

## Getting started

This image supports firmware updates using `nerves_firmware_ssh`. To use this
feature, the SSH public keys that are allowed to update the firmware need to be
added to `config/config.exs`. This process is similar to adding a key to an
`authorized_keys` file on a server. See the `config/config.exs` for where to put
your key.

Then, in this directory, run the following to build and program a MicroSD card:

```
MIX_TARGET=rpi0 mix deps.get
MIX_TARGET=rpi0 mix firmware

# Insert a MicroSD Card into a card reader and "burn" it
MIX_TARGET=rpi0 mix firmware.burn
```
Now plug the MicroSD card into a Raspberry Pi Zero. Connect your laptop or
computer to the Raspberry Pi Zero's USB port that's labeled "USB" (not the one
labeled "PWR".)

## Accessing an IEx prompt

The IEx prompt is exposed over a virtual serial port through the USB cable. When
the Raspberry Pi Zero boots you may see USB serial port driver get loaded on
your computer. Connect to it via a terminal emulator like "picocom" or "screen".
It should be something like the following:

```
picocom /dev/tty.usbmodem*
```
If you're familiar with doing this, you'll notice that the baud rate isn't
specified. It is ignored by the driver, so any baud rate should work.

## Networking

This image also exposes a virtual Ethernet interface. This interface only
supports link local IP addresses. This means that no DHCP server is needed. It
should just come up and work. The firmware runs an mDNS server that responds to
requests for `nerves.local`. Trying pinging it:
```
ping nerves.local
```

## Firmware updates

Firmware updates use an A/B system for upgrades. First the firmware is loaded to
the A slot (or partition) and then the next upgrade is written to the B slot.
When that completes, the system reboots and the B slot becomes active. The next
upgrade writes to the A slot and so on.

To run an upgrade, make sure that you can ping the device and then run the
following:
```
MIX_TARGET=rpi0 mix firmware.push nerves.local
```
You may need to pass `--passphrase <your passphrase>` if you private key is
password protected.

## Learn more about Nerves

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: http://www.nerves-project.org/
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves

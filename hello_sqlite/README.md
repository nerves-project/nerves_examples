# HelloSqlite

This example demonstrates a basic project for using the
[Ecto SQLite Adapter](https://github.com/elixir-sqlite/ecto_sqlite3).

## Hardware

The example below assumes a Raspberry Pi 0 connected over the USB. Other
official and many unofficial Nerves targets work as well.

## How to use this repository

0. Go to the `hello_sqlite` directory

1. Set up your build environment

   ```shell
   # Specify the target hardware. See the mix.exs for options
   export MIX_TARGET=rpi3

   # If using WiFi, you can set the SSID and password here
   export NERVES_NETWORK_SSID=your_wifi_name
   export NERVES_NETWORK_PSK=your_wifi_password
   ```

2. Get dependencies, build firmware, and burn it to an SD card

   ```shell
   mix deps.get
   mix firmware
   mix firmware.burn
   ```

3. Insert the SD card into your target board and power up

4. Wait to finish booting.

5. SSH into the board: `ssh nerves.local`

6. from the IEx prompt

  ```elixir
  # Get 5 entries from the SchedulerUsage table and print them out
  HelloSqlite.SchedulerUsagePoller.pretty_print(5)
   +------------------------------------------------------+
   |                   Scheduler Usage                    |
   +---------------------+---------+----------------------+
   | Timestamp           | Percent | Util                 |
   +---------------------+---------+----------------------+
   | 2021-04-07 14:53:27 | 0.0     | 4.61004300282592e-5  |
   | 2021-04-07 14:52:56 | 0.0     | 1.968093695606747e-5 |
   | 2021-04-07 14:52:25 | 0.0     | 8.095389473073943e-5 |
   | 2021-04-07 14:51:54 | 0.0     | 9.218367384342268e-6 | 
   +---------------------+---------+----------------------+
  :ok
  ```

## Learn More

- Official docs: https://hexdocs.pm/nerves/getting-started.html
- Official website: https://nerves-project.org/
- Source: https://github.com/nerves-project/nerves

- `ecto_sqlite3` docs: https://github.com/elixir-sqlite/ecto_sqlite3
- Ecto Docs: https://hexdocs.pm/ecto/

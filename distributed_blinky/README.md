# DistributedBlinky

To start your Nerves app:

  * Install dependencies with `mix deps.get`
  * Create firmware with `mix firmware`
  * Burn to an SD card with `mix firmware.burn`

## Compile notes

First node will be node identifier **2**. After that increment environment variable `NERVES_HOST_ID`. Maximum value is **255**.

Eg. `MIX_ENV=prod NERVES_HOST_ID=3 mix do deps.get, firmware`

## Distribution

Connect the nodes directly or on a switch without any DHCP (preferably). Each higher host id will look for any lower ones, but not the other way around. Initial start might take up to 10 seconds. After that it should auto recover from node failure and scale up to 50 nodes (I haven't tested that many nodes).

There are a lot of edge cases which aren't covered, but this should get you started.

## Demo

[First version](youtube.com/watch?v=hMrzUQnv44M)

## Learn more

  * Official website: http://www.nerves-project.org/
  * Discussion Slack elixir-lang #nerves
  * Source: https://github.com/nerves-project/nerves

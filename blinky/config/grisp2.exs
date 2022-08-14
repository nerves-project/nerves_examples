# Configuration for the GRiSPv2 (target grisp2)
import Config

# The GRiSP 2 has two RGB LEDs and a green LED
#
# RGB1: red:indicator-1, green:indicator-1, blue:indicator-1
# RGB2: red:indicator-2, green:indicator-2, blue:indicator-2
# phycore-green - defaults to heartbeat on boot

config :blinky,
  indicators: %{
    default: %{red: "red:indicator-1", green: "green:indicator-1", blue: "blue:indicator-1"},
    rgb2: %{red: "red:indicator-2", green: "green:indicator-2", blue: "blue:indicator-2"},
    phycore: %{green: "phycore-green"}
  }

# Configuration for the GRiSPv2 (target grisp2)
import Config

# The GRiSP 2 has two RGB LEDs and a green LED
#
# RGB1: grisp-rgb1-red, grisp-rgb1-green, grisp-rgb1-blue
# RGB2: grisp-rgb2-red, grisp-rgb2-green, grisp-rgb2-blue
# phycore-green - defaults to heartbeat on boot

config :blinky,
  indicators: %{
    default: %{red: "grisp-rgb1-red", green: "grisp-rgb1-green", blue: "grisp-rgb1-blue"},
    rgb2: %{red: "grisp-rgb2-red", green: "grisp-rgb2-green", blue: "grisp-rgb2-blue"},
    phycore: %{green: "phycore-green"}
  }

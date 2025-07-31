# Configuration for the Raspberry Pi Zero 2 W (target rpi0_2)
import Config

config :blinky,
  indicators: %{
    default: %{
      green: "ACT"
    }
  }

# Configuration for the Raspberry Pi Zero (target rpi0)
import Config

config :blinky,
  indicators: %{
    default: %{
      green: "ACT"
    }
  }

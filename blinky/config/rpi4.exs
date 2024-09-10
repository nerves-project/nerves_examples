# Configuration for the Raspberry Pi 4 (target rpi4)
import Config

config :blinky,
  indicators: %{
    default: %{
      green: "ACT"
    }
  }

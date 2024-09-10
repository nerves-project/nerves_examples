# Configuration for the Raspberry Pi 3 (target rpi3)
import Config

config :blinky,
  indicators: %{
    default: %{
      green: "ACT"
    }
  }

# Configuration for the Raspberry Pi 2 Model B (target rpi2)
import Config

config :blinky,
  indicators: %{
    default: %{
      green: "ACT"
    }
  }

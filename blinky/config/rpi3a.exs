# Configuration for the Raspberry Pi 3 Model A (target rpi3a)
import Config

config :blinky,
  indicators: %{
    default: %{
      green: "ACT"
    }
  }

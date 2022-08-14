# configuration for Beaglebone Black (target bbb)
import Config

config :blinky,
  indicators: %{
    default: %{
      green: "beaglebone:green:usr0"
    },
    led1: %{
      green: "beaglebone:green:usr1"
    },
    led2: %{
      green: "beaglebone:green:usr2"
    },
    led3: %{
      green: "beaglebone:green:usr3"
    }
  }

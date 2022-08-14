# Configuration for the Lego Mindstorms EV3 brick (target ev3)
import Config

config :blinky,
  indicators: %{
    default: %{
      red: "ev3:left:red:ev3dev",
      green: "ev3:left:green:ev3dev"
    },
    right_led: %{
      red: "ev3:right:red:ev3dev",
      green: "ev3:right:green:ev3dev"
    }
  }

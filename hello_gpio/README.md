# HelloGpio
 to use the repository
 
## Hardware

A singe led connected to GND and a GPIO pin with a 270 Ω resistor

![GPIO schematic](assets/gpio.png)

## How to use the code in the repository

1. Connect the hardware
2. Configure which output pin to use by editing `config\config.exs`
3. Get dependencies `mix deps.get`
3. Compile `mix compile`
4. Create firmware `mix firmware`
5. Burn firmware `mix firmware.burn`

The code in the repository defaults to Raspberry pi 3. If you are creating an image for any other system either edit `mix.exs` and change the target or preface all mix command with `NERVES_TARGET=rpi2 mix compile`

# How to create a new project

Create the project:

``` bash 
mix nerves.new hello_gpio --target=rpi3
cd hello_gpio
```

open mix.exs and add a dependency to `elixir_ale` and start `elixlir_ale` on boot

``` elixir
# mix.exs

# add :elixir_ale to applications
def application do
    [mod: {HelloGpio, []},
     applications: [:logger, :elixir_ale]]
end

# and add dependency to elixir_ale
def deps do
    [{:nerves, "~> 0.3.0"},
     {:elixir_ale, "~> 0.5.5"}]
end

```

Then we need to add config for which pin to use. Open config\config.exs


``` elixir
# config\config.exs

# the gpio-pin the led is connected to
config :hello_gpio, :ledpin, pin: 26
```

Then just set the pin blinking forever when the app starts:

``` elixir
@ledpin Application.get_env(:hello_gpio, :ledpin)[:pin]

def start(_type, _args) do
    IO.puts "Starting pin #{@ledpin} as output"
    {:ok, pin} = Gpio.start_link(@ledpin, :output)

    spawn fn -> blink_led_forever(pin) end
    
     {:ok, self}  
  end
  
  defp blink_led_forever(pin) do
    IO.puts "Blink!"
    Gpio.write(pin, 1)
    :timer.sleep(500)
    Gpio.write(pin, 0)
    :timer.sleep(500)
    
    blink_led_forever(pin)
  end
```

Then download dependencies, compile and burn firmware

``` bash
mix deps.get
mix compile
mix firmware
mix firmware.burn
```
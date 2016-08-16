# HelloGpio

Create the project:

``` bash 
mix nerves.new hello_gpio --target=rpi3
cd hello_gpio
```

open mix.exs and add a dependency to `elixir_ale`

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

Then vi need to add a config for which pin to use. Open config\config.exs


``` elixir
# config\config.exs

# the gpio-pin the led is connected to
config :hello_gpio, :ledpin, pin: 26
```

Then just set the pin blinking forever when the app starts:

``` elixir
@ledpin Application.get_env(:hello_gpio, :ledpin)[:pin]
  
def start(_type, _args) do
    {:ok, pin} = Gpio.start_link(@ledpin, :output)

    spawn fn -> blink_led_forever(pin) end
    
     {:ok, self}  
end
  
defp blink_led_forever(pin) do
    Gpio.write(pin, 1)
    :timer.sleep(500)
    Gpio.write(pin, 0)
    :timer.sleep(500)
    
    blink_led_forever(pin)
end  

```

To start your Nerves app:

  * Install dependencies with `mix deps.get`
  * Create firmware with `mix firmware`
  * Burn to an SD card with `mix firmware.burn`

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: http://www.nerves-project.org/
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves

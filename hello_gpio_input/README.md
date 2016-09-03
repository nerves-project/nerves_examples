# HelloGpioInput

## Hardware
A 4 pin pushbutton, 10 kΩ resistor

Schematic:

![GPIO_schematic](assets/GPIO-input.png)

## How to use the repository

1. Connect the hardware according to schematics
2. Configure which input pin to use by editiing `config/config.exs`
3. Get dependencies with `mix deps.get`
4. Compile with `mix compile`
5. Create firmware `mix firmware`
6. Insert SD card and burn firmware `mix firmware.burn`

The code in the repository defaults to Raspberry pi 3. If you are creating an image for any other system either edit `mix.exs` and change the target or preface all mix commands with in the following manner `NERVES_TARGET=rpi2 mix compile`.


# How to create a new project

Create the project:

``` bash
mix nerves.new hello_gpio_input --target=rpi3
cd hello_gpio_input
```

edit `mix.exs` and add a dependency to `elixir_ale` and start it on boot by adding it to applications:

``` elixir
# add :elixir_ale to applications                                                      
def application do                                                                     
    [mod: {HelloGpioInput, []},                                                             
     applications: [:logger, :elixir_ale]]                                             
end                                                                                    
                                                                                       
# and add dependency to elixir_ale                                                     
def deps do                                                                            
    [{:nerves, "~> 0.3.0"},                                                            
     {:elixir_ale, "~> 0.5.5"}]                                                        
end
```

Then we need to add a conveniant way to configure which pin to use for input. Edit `config.exs`

``` elixir
# config\config.exs                                                                    
                                                                                       
# the gpio-pin the that will monitor the input                                                 
config :hello_gpio_input, :inputpin, pin: 26                                           
```

Then edit lib/hello_gpio_input.ex

``` elixir
  # Read the config to aquire input pin
  @input_pin Application.get_env(:hello_gpio_input, :inputpin)[:pin]

  def start(_type, _args) do
    # Initialize the input pin
    IO.puts "Starting input on pin #{@input_pin}"
    {:ok, pid} = Gpio.start_link(@input_pin, :input)

    # Start listening for interrupts
    Gpio.set_int(pid, :both)
    loop()
  end

  defp loop() do
    # Infinite loop receiving interrupts from gpio
    receive do
      {:gpio_interrupt, p, :rising} ->
        IO.puts "Received raising event on pin #{p}"
      {:gpio_interrupt, p, :falling} ->
        IO.puts "Received fallig event on pin #{p}"
    end
    loop()
  end
```

Then download dependencies, compile and burn firmware

``` bash
mix deps.get
mix compile
mix firmware
mix firmware.burn
```

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: http://www.nerves-project.org/
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves

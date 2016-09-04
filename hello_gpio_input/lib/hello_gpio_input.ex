defmodule HelloGpioInput do
  use Application

  @input_pin Application.get_env(:hello_gpio_input, :inputpin)[:pin]

  def start(_type, _args) do
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

end

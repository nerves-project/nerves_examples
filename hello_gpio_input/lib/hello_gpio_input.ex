defmodule HelloGpioInput do
  use Application

  require Logger

  @input_pin Application.get_env(:hello_gpio_input, :inputpin)[:pin]

  def start(_type, _args) do
    Logger.debug "Starting input on pin #{@input_pin}"
    {:ok, pid} = Gpio.start_link(@input_pin, :input)

    spawn fn -> listen_forever(pid) end

    {:ok, self()}
  end

  defp listen_forever(pid) do
    # Start listening for interrupts on rising and falling edges
    Gpio.set_int(pid, :both)
    loop()
  end

  defp loop() do
    # Infinite loop receiving interrupts from gpio
    receive do
      {:gpio_interrupt, p, :rising} ->
        Logger.debug "Received rising event on pin #{p}"
      {:gpio_interrupt, p, :falling} ->
        Logger.debug "Received falling event on pin #{p}"
    end
    loop()
  end

end

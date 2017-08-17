defmodule HelloGpio do
  use Application

  require Logger

  alias ElixirALE.GPIO

  @output_pin Application.get_env(:hello_gpio, :output_pin, 26)
  @input_pin Application.get_env(:hello_gpio, :input_pin, 20)

  def start(_type, _args) do
    Logger.info "Starting pin #{@output_pin} as output"
    {:ok, output_pid} = GPIO.start_link(@output_pin, :output)
    spawn fn -> toggle_pin_forever(output_pid) end

    Logger.info "Starting pin #{@input_pin} as input"
    {:ok, input_pid} = GPIO.start_link(@input_pin, :input)
    spawn fn -> listen_forever(input_pid) end
    {:ok, self()}
  end

  defp toggle_pin_forever(output_pid) do
    Logger.debug "Turning pin #{@output_pin} ON"
    GPIO.write(output_pid, 1)
    Process.sleep(500)

    Logger.debug "Turning pin #{@output_pin} OFF"
    GPIO.write(output_pid, 0)
    Process.sleep(500)

    toggle_pin_forever(output_pid)
  end

  defp listen_forever(input_pid) do
    # Start listening for interrupts on rising and falling edges
    GPIO.set_int(input_pid, :both)
    listen_loop()
  end

  defp listen_loop() do
    # Infinite loop receiving interrupts from gpio
    receive do
      {:gpio_interrupt, p, :rising} ->
        Logger.debug "Received rising event on pin #{p}"
      {:gpio_interrupt, p, :falling} ->
        Logger.debug "Received falling event on pin #{p}"
    end
    listen_loop()
  end

end

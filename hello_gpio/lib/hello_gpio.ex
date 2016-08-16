defmodule HelloGpio do
  use Application§
  
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

end

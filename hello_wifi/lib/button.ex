defmodule HelloWiFi.Button do
  use GenServer

  @moduledoc """
  This GenServer starts the wizard if a button is depressed for long enough.
  """

  alias Circuits.GPIO

  @doc """
  Start the button monitor

  Pass an index to the GPIO that's connected to the button.
  """
  @spec start_link(non_neg_integer()) :: GenServer.on_start()
  def start_link(gpio_pin) do
    GenServer.start_link(__MODULE__, gpio_pin)
  end

  @impl true
  def init(gpio_pin) do
    {:ok, gpio} = GPIO.open(gpio_pin, :input)
    :ok = GPIO.set_interrupts(gpio, :both)
    {:ok, %{pin: gpio_pin, gpio: gpio}}
  end

  @impl true
  def handle_info({:circuits_gpio, gpio_pin, _timestamp, 1}, %{pin: gpio_pin} = state) do
    # Button pressed. Start a timer to launch the wizard when it's long enough
    {:noreply, state, 5_000}
  end

  @impl true
  def handle_info({:circuits_gpio, gpio_pin, _timestamp, 0}, %{pin: gpio_pin} = state) do
    # Button released. The GenServer timer is implicitly cancelled by receiving this message.
    {:noreply, state}
  end

  @impl true
  def handle_info(:timeout, state) do
    :ok = VintageNetWizard.run_wizard(on_exit: {HelloWiFi, :on_wizard_exit, []})
    {:noreply, state}
  end
end

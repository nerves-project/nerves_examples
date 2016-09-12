defmodule ConfigurableBlinky do
  use Application

  @moduledoc """
  This is the main module. It is composed of two submodules: `BlinkConfigWorker` and `BlinkWorker`.
  """

  # Initial duration of the on and off signals
  @init_on_duration 100
  @init_off_duration 100

  defmodule BlinkConfigWorker do
    use GenServer

    require Logger

    @moduledoc """
    This module contains the code used to create a process for holding the
    configuration of the blinking. The configuration comprises of:

    * the time during which the light is on, in ms,
    * the time during which the light is off, in ms,
    * and whether or not the blinking process is on.

    The process responsible for blinking will query this process by
    issuing a `:get_durations` call. The process can be halted with
    a `:stop` call, and restarted with a `:start` call.
    """

    def start_link(state, opts \\ []) do
      Logger.debug "Initial state is #{inspect state}"
      GenServer.start_link(__MODULE__, state, opts)
       {:ok, self}
    end

    def handle_call(:get_durations, _from, context) do
      #Logger.debug "Getting durations #{inspect context}"
      {on, off, _running} = context
      {:reply, {on, off}, context}
    end

    @doc """
    Return `true` if the blinking process is running.
    """
    def handle_call(:is_running, _from, context) do
      {:reply, elem(context, 2), context}
    end

    @doc """
    Change the time during which the light is off.
    """
    def handle_cast({:set_off_duration, duration}, context) do
      {old_on_duration, _old_off_duration, running} = context
      {:noreply, {old_on_duration, duration, running}}
    end

    @doc """
    Change the time during which the light is on.
    """
    def handle_cast({:set_on_duration, duration}, context) do
      {_old_on_duration, old_off_duration, running} = context
      {:noreply, {duration, old_off_duration, running}}
    end

    def handle_cast(:stop, context) do
      {on, off, _old_running} = context
      {:noreply, {on, off, false} }
    end

    def handle_cast(:start, context) do
      {on, off, _old_running} = context
      {:noreply, {on, off, true} }
    end
  end

  defmodule BlinkWorker do
    use GenServer

    @moduledoc """
    This module contains the code that is turning the leds on and
    off. It gets its timing from the configuration process.
    """

    alias Nerves.Leds

    def start_link(state, opts \\ []) do
      GenServer.start_link(__MODULE__, state, opts)
      led_list = Application.get_env(:configurable_blinky, :led_list)
      spawn fn -> blink_list(led_list) end
      {:ok, self}
    end

    defp blink_list(led_list) do
      Enum.each(led_list, &blink(&1))
      blink_list(led_list) #unless self.stopped
    end

    @doc """
    Actual blinking function. See the `blinky` example.
    """
    defp blink(led_key) do
      running = GenServer.call(BlinkConfig, :is_running)
      if running do
        {on_duration, off_duration} = GenServer.call(BlinkConfig, :get_durations)
        Leds.set [{led_key, true}]
        :timer.sleep on_duration
        Leds.set [{led_key, false}]
        :timer.sleep off_duration
      end
    end
  end

  @doc """
  start of the application, create a configuration process, and a
  process controlling the blinking.
  """
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      worker(ConfigurableBlinky.BlinkConfigWorker, [{@init_on_duration, @init_off_duration, true}, [name: BlinkConfig]]),
      worker(ConfigurableBlinky.BlinkWorker, [[name: Blinker]]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ConfigurableBlinky.Supervisor]
    Supervisor.start_link(children, opts)
  end

end

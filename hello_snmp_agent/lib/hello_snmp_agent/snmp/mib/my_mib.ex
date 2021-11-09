defmodule HelloSnmpAgent.Mib.MyMib do
  @moduledoc """
  This is the where the 'instrumentation' functions go that match what you have
  in hello_snmp_agent/mibs/MY-MIB.mib.
  """

  use Snmp.Mib, name: "MY-MIB"

  alias Circuits.GPIO

  def someObjectIFOutput(:get) do
    {:ok, gpio} = GPIO.open(26, :output)
    value = GPIO.read(gpio)

    {:value, value}
  end

  @doc """
  Naturally, you'd usually follow the pattern of having a GenServer to interact
  with GPIO. This is here just to demonstrate how to easily interact via SNMP.
  """
  def someObjectIFOutput(:set, val) do
    {:ok, gpio} = GPIO.open(26, :output)
    GPIO.write(gpio, val)

    :noError
  end

  def someObjectIFLevel(:get), do: {:value, 123}
  def someObjectIFLevel(:set, _val), do: :noError
end

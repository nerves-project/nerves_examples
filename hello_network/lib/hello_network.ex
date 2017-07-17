defmodule HelloNetwork do
  @moduledoc """
  Example of setting up Networking on a Nerves device.
  """

  alias Nerves.{Network, Udhcpc}

  @interface "eth0"
  @settings [ipv4_address_method: :dhcp]

  @doc "Main entry point into the program. This is an OTP callback."
  def start(_type, _args) do
    GenServer.start_link(__MODULE__, {@interface, @settings}, [name: __MODULE__])
  end

  @doc "Are we connected to the internet?"
  def connected?, do: GenServer.call(__MODULE__, :connected?)

  @doc "Returns the current ip address"
  def ip_addr, do: GenServer.call(__MODULE__, :ip_addr)

  @doc """
  Attempts to perform a DNS lookup to test connectivity.

  ## Examples

    iex> HelloNetwork.test_dns()
    {:ok,
     {:hostent, 'nerves-project.org', [], :inet, 4,
      [{192, 30, 252, 154}, {192, 30, 252, 153}]}}
  """
  def test_dns(hostname \\ 'nerves-project.org') do
    :inet_res.gethostbyname(hostname)
  end

  ## GenServer callbacks

  def init({interface, settings}) do
    Network.setup(interface, settings)
    {:ok, _} = Registry.register(Udhcpc, interface, [])
    state = %{ip_address: nil,
              connected: false,
              interface: @interface
            }

    # Return our initial state.
    {:ok, state}
  end

  def handle_info({Udhcpc, :bound, %{ifname: interface, ipv4_address: ip}}, %{interface: iface} = state) when iface == interface do
    case test_dns() do
      {:hostent, 'nerves-project.org', [], :inet, 4, _} ->
        {:noreply, %{state | connected: true, ip_address: ip}}
      _ -> {:noreply, %{state | connected: false, ip_address: ip}}
    end
  end

  def handle_info(_, state), do: {:noreply, state}

  def handle_call(:connected?, _from, state), do: {:reply, state.connected}
  def handle_call(:ip_addr, _from, state), do: {:reply, state.ip_address}
end

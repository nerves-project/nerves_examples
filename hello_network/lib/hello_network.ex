defmodule HelloNetwork do
  @moduledoc """
  Example of setting up wired and wireless networking on a Nerves device.
  """

  require Logger

  alias Nerves.Network

  @interface Application.get_env(:hello_network, :interface, :eth0)

  @doc "Main entry point into the program. This is an OTP callback."
  def start(_type, _args) do
    GenServer.start_link(__MODULE__, to_string(@interface), [name: __MODULE__])
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

  def init(interface) do
    Network.setup(interface)

    SystemRegistry.register
    {:ok, %{ interface: interface, ip_address: nil, connected: false }}
  end

  def handle_info({:system_registry, :global, registry}, state) do
    ip = get_in registry, [:state, :network_interface, state.interface, :ipv4_address]
    if ip != state.ip_address do
      Logger.info "IP ADDRESS CHANGED: #{ip}"
    end

    connected = match?({:ok, {:hostent, 'nerves-project.org', [], :inet, 4, _}}, test_dns())
    {:noreply, %{state | ip_address: ip, connected: connected || false}}
  end

  def handle_info(_, state), do: {:noreply, state}

  def handle_call(:connected?, _from, state), do: {:reply, state.connected, state}
  def handle_call(:ip_addr, _from, state), do: {:reply, state.ip_address, state}
end

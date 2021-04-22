defmodule HelloSnmpManager do
  @moduledoc """
  Simple example to poll a remote network element via SNMP. This
  demonstrates using a single request to obtain two OIDs from the
  remote system.

  The remote host to poll (the "agent") is specified in the SNMP
  `agent.conf` configuration file. See the README.md for details
  on this file's settings.

  See README.md for build instructions.
  """
  use GenServer

  require Logger

  # Durations are in milliseconds
  @polling_interval 10_000

  @spec start_link(keyword()) :: GenServer.on_start()
  def start_link(init_args) do
    GenServer.start_link(__MODULE__, init_args)
  end

  @impl GenServer
  def init(_init_args) do
    Logger.debug("Starting SNMP Poller")
    _ = :timer.send_interval(@polling_interval, :tick)
    {:ok, :no_state}
  end

  @impl GenServer
  def handle_info(:tick, state) do
    Logger.debug("Sending SNMP Request for System Information")

    :snmpm.sync_get('default_user', 'default_agent', [
      # OID for sysDescr
      [1, 3, 6, 1, 2, 1, 1, 1, 0],
      # OID for sysName
      [1, 3, 6, 1, 2, 1, 1, 5, 0]
    ])
    |> parse_response()

    {:noreply, state}
  end

  defp parse_response({:ok, _, _} = snmp_response) do
    {_status,
     {_, _,
      [
        {_, _, _, system_description, _},
        {_, _, _, system_name, _}
      ]}, _} = snmp_response

    Logger.debug("SNMP Response Successful")
    Logger.debug("System Name: #{system_name}")
    Logger.debug("System Description: #{system_description}")
  end

  defp parse_response({:error, _, _} = _snmp_response) do
    Logger.debug("SNMP Response Failed")
  end

  defp parse_response(_snmp_response) do
    Logger.debug("SNMP Response Failed")
  end
end

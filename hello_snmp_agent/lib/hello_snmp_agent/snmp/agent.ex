defmodule HelloSnmpAgent.Agent do
  @moduledoc """
  Example Agent which is used by the elixir-snmp dependency to generate some
  SNMP-related files. The numbers at the end of the example snmp commands listed
  below are called 'oids', they must correspond to what is in your
  hello_snmp_agent/mibs/*.mib and what you list below via the mib macro.

  Example commands:
    on host:
      - snmpwalk -c public localhost .1.3.6.1.3.17
      - snmpget  -c public localhost .1.3.6.1.3.17.1.0
      - snmpget  -c public localhost .1.3.6.1.3.17.2.0
      - snmpset  -c public localhost .1.3.6.1.3.17.1.0 i 0

    on target:
      - snmpwalk -c public nerves.local .1.3.6.1.3.17
      - snmpget  -c public nerves.local .1.3.6.1.3.17.1.0
      - snmpget  -c public nerves.local .1.3.6.1.3.17.2.0
      - snmpset  -c public nerves.local .1.3.6.1.3.17.1.0 i 0
  """
  use Snmp.Agent.Handler, otp_app: :hello_snmp_agent

  # Mandatory MIBs
  mib(Standard)
  mib(Framework)

  # Application MIBs
  mib(HelloSnmpAgent.Mib.MyMib)

  # VACM model
  view :public do
    # Experimental
    include([1, 3, 6, 1, 3])
  end

  view :private do
    include([1, 3, 6])
  end

  # Typically you would not set everything to public, this is here for easy
  # demonstration purposes (easy to issue snmpwalk/snmpget/snmpset commands)
  access(:public,
    versions: [:v1, :v2c, :usm],
    level: :noAuthNoPriv,
    read_view: :public,
    write_view: :public,
    notify_view: :public
  )

  access(:secure,
    versions: [:usm],
    level: :authPriv,
    read_view: :private,
    write_view: :private,
    notify_view: :private
  )
end

defmodule Framework do
  use Snmp.Mib.Framework,
    otp_app: :hello_snmp_agent,
    conf: [
      {:snmpEngineID, [1]},
      {:snmpEngineMaxMessageSize, 1500}
    ]
end

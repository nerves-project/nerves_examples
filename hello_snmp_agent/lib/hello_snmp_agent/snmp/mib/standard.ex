defmodule Standard do
  use Snmp.Mib.Standard,
    otp_app: :hello_snmp_agent,
    conf: [
      {:sysObjectID, [1, 2, 3]},
      {:sysServices, 72},
      {:snmpEnableAuthenTraps, :disabled}
    ]
end

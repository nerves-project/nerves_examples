# HelloSnmpAgent

Demonstrate running an SNMP agent on a Nerves device.

This example uses [elixir-snmp](https://github.com/jeanparpaillon/elixir-snmp).

## Hardware

The example was developed with a Raspberry Pi 3 but any Nerves-supported
hardware should work.

## Erlang Configuration Files for SNMP

[Erlang Agent
Documentation](https://erlang.org/doc/apps/snmp/snmp_impl_example_agent.html#association-file)

## Host and Target Configurations

A number of SNMP-related files are created, see Jean Parpaillon's notes in the
`tl;dr` section below if you're interested in the details. In short, these files
need to be on your target in a place where your app can find them and use them.
We use the `config/config.exs`, `config/target.exs`, `mix.exs` to make those
files be in the right place. Relevant configuration lines related to that for
this application may be found in:

### mix.exs

```elixir
def project do
  ...
  compilers: [:mib | Mix.compilers()],
  ...
end
```

### config/host.exs

```elixir
config :hello_snmp_agent, HelloSnmpAgent.Agent,
  dir: './priv/',
  versions: [:v1, :v2, :v3],
  port: "SNMP_PORT" |> System.get_env("161") |> String.to_integer(),
  transports: ["127.0.0.1"],
  security: [
    [user: "public", password: "password", access: :public],
    [user: "admin", password: "adminpassword", access: [:public, :secure]]
  ]
```

### config/target.exs

```elixir
config :hello_snmp_agent, HelloSnmpAgent.Agent,
  dir: '/root/'
```

## SNMP Resources

[ERLANG Documentation - SNMP Users Guide](http://erlang.org/doc/apps/snmp/snmp_intro.html)
[elixir-snmp](https://github.com/jeanparpaillon/elixir-snmp)

## How to use the code in this repository

1. `export WIFI_PSK="my psk"`
2. `export WIFI_SSID="my ssid"`
The `REG_DOM` below is used in `hello_snmp_agent/config/target.exs` for
vintage_net config, see https://github.com/nerves-networking/vintage_net and/or
[ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2):
3. `export REG_DOM="my country code"` ("US" for example)
4. `export MIX_TARGET="my target"`
5. `mix deps.get`

Test SNMP on the `host` by running `snmpwalk` (with your `IEx` session running)
6. `MIX_TARGET=host mix deps.get`
7. `iex -S mix`
from the command line with `IEx` still running:
8. `snmpwalk -c public localhost .1.3.6.1.3.17`\
  You should see the following, **if you do not then just stop the `IEx`
  session and restart it and issue the SNMP command again:**

  ```text
  SNMPv2-SMI::experimental.17.1.0 = INTEGER: 1
  SNMPv2-SMI::experimental.17.2.0 = INTEGER: 123
  SNMPv2-SMI::experimental.17.2.0 = No more variables left in this MIB View (It is past the end of the MIB tree)
  ```

9. Remember that you should have `WIFI_PSK`, `WIFI_SSID`, `REG_DOM`, and
   `MIX_TARGET` (as your `target`, not `host`) set already. Confirm with:

  ```sh
  echo $WIFI_PSK
  echo $WIFI_SSID
  echo $REG_DOM
  echo $MIX_TARGET
  ```

10. Insert SD card into your `host` machine
11. `mix firmware.burn`
12. Insert SD card into your `target` device, power it on, wait a few seconds.
13. `snmpwalk -c public nerves.local .1.3.6.1.3.17`
    You should see (**if you do not then wait a few more seconds and try again**):

    ```text
    SNMPv2-SMI::experimental.17.1.0 = INTEGER: 1
    SNMPv2-SMI::experimental.17.2.0 = INTEGER: 123
    SNMPv2-SMI::experimental.17.2.0 = No more variables left in this MIB View (It is past the end of the MIB tree)
    ```

14. In `lib/hello_snmp_agent/snmp/mib/my_mib.ex`, we defined
    `someObjectIFOutput` to be able to read and write pin 26. Our
    `hello_snmp_agent/mibs/MY-MIB.mib` said the `oid` (`SNMP` identifier) for
    this is `.1.3.6.1.3.17.1.0` and that valid values are `0` or `1`. So, ssh to
    your target and get the value for pin 26 (steps 15-18):
15. `ssh nerves.local`
16. Run the following at the IEx prompt:

    ```elixir
    {:ok, gpio} = Circuits.GPIO.open(26, :output)
    Circuits.GPIO.read(gpio)
    0
    ```

17. Now issue an snmpset command from any machine on your network that has snmp
    tools installed: `snmpset -c public nerves.local .1.3.6.1.3.17.1.0 i 1`. You
    should see `SNMPv2-SMI::experimental.17.1.0 = INTEGER: 1`, **if you do not,
    then just wait a few seconds and try again.**
18. Verify in your `target` device that the pin 26 was updated:

  ```elixir
  Circuits.GPIO.read(gpio)
  1
  ```

## tl;dr

### Agent Dir

Agent configuration dir (`config :my_app, MyAgentModule, dir: "/root/..."`) must
be writable.

`#{dir}/conf` contains configuration files created at runtime
`#{dir}/db` contains (custom SNMP) DB with data persisted across reboots.

#### Agent conf rationale

SNMP agent requires 9 (erlang) configuration files. Some configuration may be
provided at runtime (from env vars, or elixir logic, for instance) and so can
not be generated at compile time. OTP's SNMP library does not allow for passing
configuration another way. While it is in line with OTP applications, it does
not suit elixir standards where configuration is not always defined at compile
time.

So, `elixir-snmp` takes care of compiling configuration into those 9 files then
start SNMP agent, through the `Snmp.Agent.Config` module.

### MIB compiled files

SNMP agent requires a 3rd kind of resources: MIB compiled files (`*.bin`). They
are `term_to_binary`'d version of a [MIB
record](https://github.com/erlang/otp/blob/master/lib/snmp/include/snmp_types.hrl#L215)

In case SNMP agent uses dependant MIBs (MIB with `IMPORT` statements), `*.mib`
must be compiled into `*.bin` files prior to compiling elixir code. So, it is
recommended to add `:mib` compiler in the list of compilers:

```elixir
def project do
  ...
  compilers: [:mib | Mix.compilers()]
  ...
end
```

## Learn More

* Official docs: https://hexdocs.pm/nerves/getting-started.html
* Official website: https://nerves-project.org/
* Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
* Source: https://github.com/nerves-project/nerves

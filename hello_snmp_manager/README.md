# HelloSnmpManager

Demonstrates a configuration for using the Nerves target to SNMP poll a remote device.

## Hardware

No additional hardware serviced by the target (GPIO, I2C, etc..) is required for 
this demonstration. You will need a device capable on the target's network capable
of responding to SNMP requests.

## Erlang Configuration Files for SNMP

There are three configuration files located in `rootfs_overlay/snmp` for setting up
the Erlang SNMP application:

* `manager.conf`
* `users.conf`
* `agents.conf`

The individual values in these files are documented here:  

[Erlang - Manager Information](http://erlang.org/doc/apps/snmp/snmp_manager_config_files.html#manager_information)

Typically you will only need to adjust the `agents.conf` file to add your devices as
polling endpoints. In this example the remote host is assumed to run SNMP version 2c
with a community-string of `public` at the IP address `192.168.1.1`. Note that the 
configuration file expects a list of integers, not a dotted-decimal format (the same
will be true for any SNMP OIDs in the polling calls).

## Host and Target Configurations

These three configuration files above files must be present in the filesystem
so this project places them inside the `rootfs_overlay/snmp` folder. This will 
be available to the target as `/snmp/...` at the root level in the file-system.

The SNMP applciation also requires a read-write path for the database file. 
Database files will be created if they do not exist. A `/tmp` folder is available
for most build targets that has read/write privileges for the Nerves application.

The relevant lines for these configuring these paths may be found in the two files:

**config/host.exs**  
```config :snmp, :manager, config: [dir: './rootfs_overlay/snmp', db_dir: '/tmp']```

**config/target.exs**  
```config :snmp, :manager, config: [dir: '/snmp', db_dir: '/tmp']```

Note the use of the relative path for the host environment while an absolute path
is specified for the build target.

## SNMP Resources
[ERLANG Documentation - SNMP Users Guide](http://erlang.org/doc/apps/snmp/snmp_intro.html)  
[Ernie.io - SNMP in Elixir](https://ernie.io/2014/07/10/snmp-in-elixir/)

## How to Use the Code in this Repository

1. Specify your target with the `MIX_TARGET` environment variable
2. Get dependencies with `mix deps.get`
3. Create firmware with `mix firmware`
4. Burn firmware to an SD card with `mix firmware.burn`
5. Insert the SD card into your target board and power it on
6. Log into the target board and view the logs with `RingLogger.attach`
7. The SNMP response from the remote element will log every 5 seconds

## Example Logs
```
23:36:41.352 [debug] Sending SNMP Request for System Information

23:36:41.366 [debug] SNMP Response Succesful

23:36:41.366 [debug] System Name: router.example.com

23:36:41.366 [debug] System Name: Cisco IOS Software, 1841 Software (C1841-ADVENTERPRISEK9-M), Version 15.1(4)M7, RELEASE SOFTWARE (fc2)
Technical Support: http://www.cisco.com/techsupport
Copyright (c) 1986-2013 by Cisco Systems, Inc.
Compiled Sun 15-Sep-13 23:44 by prod_rel_team
```

## Example Firmware Build

``` bash
export MIX_TARGET=rpi0
mix deps.get
mix firmware
mix firmware.burn
```

## Learn More

* Official docs: https://hexdocs.pm/nerves/getting-started.html
* Official website: https://nerves-project.org/
* Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
* Source: https://github.com/nerves-project/nerves

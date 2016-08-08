# HelloNetwork

Configures the primary network interface using [DHCP] and announces itself
on the network using [SSDP].

You can start this example and then find your device on the network using the
`cell` command-line tool (see the [`cell-tool`] project).

### Limitations

Supports only [IPv4LL] and DHCP addressing (no interface for static IPv4
configuration yet).

### Roadmap

- [ ] Add documentation.
- [ ] Add support for static IPv4 configuration.
- [ ] Add test cases.

[DHCP]:        https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol
[SSDP]:        https://en.wikipedia.org/wiki/Simple_Service_Discovery_Protocol
[`cell-tool`]: https://github.com/nerves-project/cell-tool
[IPv4LL]:      https://en.wikipedia.org/wiki/Zero-configuration_networking#Link-local_IPv4_addresses

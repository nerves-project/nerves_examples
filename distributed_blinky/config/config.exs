# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Import target specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Uncomment to use target specific configurations

host_id = "#{Mix.Project.config[:host_id]}"

# magic to get initial node list
int_host_id = String.to_integer(host_id)
initial_nodes = for id <- 2..int_host_id do
  id = to_string(id)
  String.to_atom(id <> "@10.0.10." <> id)
end

config :distributed_blinky, if_eth0: [
    mode: "static",
    ip: "10.0.10." <> host_id,
    router: "10.0.10.1",
    mask: "24",
    subnet: "255.255.255.0",
    hostname: "blinky_" <> host_id
  ],

  initial_nodes: initial_nodes ++ [:'1@127.0.0.1']

import_config "#{Mix.Project.config[:target]}/config.exs"

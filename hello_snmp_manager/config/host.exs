import Config

# Add configuration that is only needed when running on the host here.

# SNMP Manager with relatives paths
config :snmp, :manager, config: [dir: ~c"./rootfs_overlay/snmp", db_dir: ~c"./tmp"]

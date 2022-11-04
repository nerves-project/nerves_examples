import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.

read_or_gen_secret = fn path, len ->
  if File.exists?(path) do
    File.read!(path)
  else
    # Implementation of mix phx.gen.secret
    secret =
      :crypto.strong_rand_bytes(len)
      |> Base.encode64(padding: false)
      |> binary_part(0, len)

    # Just attempt to store
    _ = File.write(path, secret)
    secret
  end
end

if config_target() != :host do
  # This is evaluated on device and has the contents of the device
  # file system available. So we'll showcase here reading in some
  # values stored on disk for the secret_key_base and live_view signing salt
  data_dir = "/data/hello_phoenix"
  File.mkdir_p!(data_dir)

  skb = read_or_gen_secret.(Path.join(data_dir, "skb"), 64)
  lvss = read_or_gen_secret.(Path.join(data_dir, "lvss"), 8)

  config :hello_phoenix, HelloPhoenixWeb.Endpoint,
    live_view: [signing_salt: lvss],
    secret_key_base: skb
end

if config_env() == :prod do
  config :ui, HelloPhoenixWeb.Endpoint,
    http: [
      # Enable IPv6 and bind on all interfaces.
      # Set it to  {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
      # See the documentation on https://hexdocs.pm/plug_cowboy/Plug.Cowboy.html
      # for details about using IPv6 vs IPv4 and loopback vs public addresses.
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: String.to_integer(System.get_env("PORT") || "4000")
    ]
end

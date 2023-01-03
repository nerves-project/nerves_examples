import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hello_live_view, HelloLiveViewWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "skPYVgOS63ZmbyfKrcf4OwImk+OQiYt/I5fCzPvFzMIeg2vq1HYvNxAyIkntZVKk",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

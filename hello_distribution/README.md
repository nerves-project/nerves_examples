# Hello Distribution

This example builds a Nerves firmware image for supported Nerves devices that demonstrates using Mdns Lite, Erlang Distribution and Phoenix PubSub
to build a communication mechanism between two or more Nerves devices.

This example has all the same configuration as the [https://github.com/nerves-project/nerves_examples/tree/main/hello_wifi](Hello WiFi Example).

The first step will be to build firmware for your boards:

```bash
cd hello_distribution

# Set the target to rpi0, rpi3, or rpi4 depending on what you have
export MIX_TARGET=rpi0
mix deps.get
mix firmware

# Insert a MicroSD card or whatever media your board takes
mix burn
```

Next configure the board so it connects to you WiFi network.

Finally, open two ssh sessions - one to each board and use `Node.connect/1` to connect them via Erlang Distribution.
For example (you will need to replace `nerves-bea0.local` with your devices hostname.)

```elixir
iex(hello@nerves-080c.local)4> Node.connect(:"hello@nerves-bea0.local")
true
```

Once connected, you can use Phoenix PubSub to send messages back and forth on the network:

on one device:

```elixir
iex(hello@nerves-bea0.local)3> Phoenix.PubSub.subscribe(HelloDistribution.PubSub, "test-event") 
```

and the other:

```elixir
iex(hello@nerves-080c.local)5> Phoenix.PubSub.broadcast(HelloDistribution.PubSub, "test-event", {:hello, :world})
```

Now back on the first device, you should be able to see the message:

```elixir
iex(hello@nerves-bea0.local)> flush
...(hello@nerves-bea0.local)5> flush()
{:hello, :world}
```

# Firmware statistics for nerves-examples

This branch collects statistics on the Nerves examples from CI builds.

## Creating charts

This is currently a manual process.

```sh
cd gengraph
mix deps.get
mix escript.build
./gengraph
```

You should see a bunch of `.png` files in the current directory.

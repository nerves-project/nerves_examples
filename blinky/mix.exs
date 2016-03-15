defmodule Blinky.Mixfile do

  use Mix.Project

  def project do
    [app: :blinky,
     version: "0.0.2",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:nerves, :logger, :nerves_io_led, :crypto],
     mod: {Blinky, []}]
  end

  defp deps, do: [
    {:nerves, "~> 0.2"},
    {:nerves_io_led, github: "nerves-project/nerves_io_led"}
  ]

end

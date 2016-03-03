defmodule HelloNetwork.Mixfile do

  use Mix.Project

  def project do
    [app: :hello_network,
     version: "0.0.2",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application, do: [
    applications: [:nerves, :logger, :nerves_io_ethernet],
    mod: {HelloNetwork, [:nerves_io_ethernet]}
  ]

  defp deps, do: [
    {:nerves, "~> 0.2"},
    {:nerves_io_ethernet, github: "nerves-project/nerves_io_ethernet", tag: "v0.5.1"}
  ]

end

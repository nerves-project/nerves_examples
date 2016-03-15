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
    mod: {HelloNetwork, []},
    applications: [:nerves, :logger,
                   :nerves_networking,
                   :nerves_ssdp_server,
                   :nerves_lib]
  ]

  defp deps, do: [
    {:nerves, "~> 0.2"},
    {:nerves_lib, github: "nerves-project/nerves_lib"},
    {:nerves_networking, github: "nerves-project/nerves_networking", tag: "v0.6.0"}
    {:nerves_ssdp_server, github: "nerves-project/nerves_ssdp_server"}
  ]

end

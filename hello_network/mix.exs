defmodule HelloNetwork.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi2"

  def project do
    [app: :hello_network,
     version: "0.1.0",
     elixir: "~> 1.3",
     archives: [nerves_bootstrap: "~> 0.1.3"],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     target: @target,
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     aliases: aliases(),
     deps: deps() ++ system(@target)]
  end

  def application do
    [mod: {HelloNetwork, []},
     applications: [:logger,
                    :nerves_networking,
                    :nerves_ssdp_server,
                    :nerves_lib]]
  end

  defp deps do
    [{:nerves, "~> 0.3.0"},
     {:nerves_lib, github: "nerves-project/nerves_lib"},
     {:nerves_networking, github: "nerves-project/nerves_networking", tag: "v0.6.0"},
     {:nerves_ssdp_server, github: "nerves-project/nerves_ssdp_server"}]
  end

  def system(target) do
    [
     {:"nerves_system_#{target}", "~> 0.6"}
    ]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end

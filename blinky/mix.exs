defmodule Blinky.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi3"

  def project do
    [app: :blinky,
     version: "0.3.0",
     elixir: "~> 1.4.0",
     archives: [nerves_bootstrap: "~> 0.2.1"],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     target: @target,
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     aliases: aliases(),
     deps: deps() ++ system(@target)]
  end

  def application do
    [mod: {Blinky, []},
     extra_applications: [:logger]]
  end

  defp deps do
    [{:nerves, "~> 0.4.7"},
     {:nerves_leds, "~> 0.7.0"}]
  end

  def system(target) do
    [
     {:"nerves_system_#{target}", "~> 0.10.0", runtime: false}
    ]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths",    "nerves.loadpaths"]]
  end

end

defmodule Blinky.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi"

  def project do
    [app: :blinky,
     version: "0.1.0",
     archives: [nerves_bootstrap: "~> 0.1.2"],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     target: @target,
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     aliases: aliases(),
     deps: deps() ++ system(@target)]
  end

  def application do
    [applications: [:nerves, :logger, :nerves_io_led],
     mod: {Blinky, []}]
  end

  defp deps do
    [{:nerves, "~> 0.3.0"},
     {:nerves_io_led, github: "nerves-project/nerves_io_led"}]
  end

  def system(target) do
    [{:"nerves_system_#{target}", ">= 0.0.0"}]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths",    "nerves.loadpaths"]]
  end

end

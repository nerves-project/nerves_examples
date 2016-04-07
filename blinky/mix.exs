defmodule Blinky.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi2"

  def project do
    [app: :blinky,
     version: "0.1.0",
     archives: [nerves_bootstrap: "~> 0.1"],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     target: @target,
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     config_path: "config/#{@target}/config.exs",
     aliases: aliases,
     deps: deps ++ system(@target)]
  end

  def application do
    [applications: [:nerves, :logger, :nerves_io_led],
     mod: {Blinky, []}]
  end

  defp deps, do: [
    {:nerves, github: "nerves-project/nerves", branch: "mix"},
    {:nerves_io_led, github: "nerves-project/nerves_io_led"}
  ]

  def system("alix") do
    [{:nerves_system_alix, github: "nerves-project/nerves_system_alix"}]
  end

  def system("ev3") do
    [{:nerves_system_ev3, github: "nerves-project/nerves_system_ev3"}]
  end

  def system("bbb") do
    [{:nerves_system_bbb, github: "nerves-project/nerves_system_bbb"}]
  end

  def system("rpi") do
    [{:nerves_system_rpi, github: "nerves-project/nerves_system_rpi"}]
  end

  def system("rpi2") do
    [{:nerves_system_rpi2, github: "nerves-project/nerves_system_rpi2"}]
  end

  def system("rpi3") do
    [{:nerves_system_rpi3, github: "../nerves_system_rpi3"}]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["nerves.loadpaths", "deps.loadpaths"]]
  end

end

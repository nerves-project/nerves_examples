defmodule HelloLeds.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi"

  def project do
    [app: :hello_leds,
     version: "0.2.0",
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
    [mod: {HelloLeds, []},
     applications: [:logger, :nerves_leds]]
  end

  defp deps do
    [{:nerves, "~> 0.3.0"},
     {:nerves_leds, "~> 0.7.0"}]
  end

  def system(target) do
    [
     {:"nerves_system_#{target}", "~> 0.6"}
    ]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths",    "nerves.loadpaths"]]
  end

end

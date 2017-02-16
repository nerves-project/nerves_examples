defmodule Fw.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi3"

  def project do
    [app: :fw,
     version: "0.1.0",
     elixir: "~> 1.4.0",
     target: @target,
     archives: [nerves_bootstrap: "~> 0.2.1"],
     deps_path: "../../deps/#{@target}",
     build_path: "../../_build/#{@target}",
     lockfile: "../../mix.lock",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps() ++ system(@target)]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Fw, []},
     applications: [:logger, :ui, :nerves_networking]]
  end

  def deps do
    [{:nerves, "~> 0.4.7"},
     {:nerves_networking, "~> 0.6.0"},
     {:ui, in_umbrella: true}]
  end

  def system(target) do
    [{:"nerves_system_#{target}", "~> 0.10.0"}]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end

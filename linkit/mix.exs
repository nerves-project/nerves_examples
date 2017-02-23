defmodule Linkit.Mixfile do
  use Mix.Project

  @target "linkit"

  def project do
    [app: :linkit,
     version: "0.1.0",
     elixir: "~> 1.4.0",
     archives: [nerves_bootstrap: "~> 0.2.1"],
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     target: @target,
     aliases: aliases(),
     deps: deps() ++ system(@target)]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Linkit, []},
     extra_applications: [:logger]]
  end

  def deps do
    [{:nerves, "~> 0.4.7"},
     {:nerves_uart, "~> 0.1.1"},
     {:elixir_ale, "~> 0.5.7"},
     {:firmata, github: "kfatehi/firmata"}]
  end

  def system(target) do
    [{:"nerves_system_#{target}", "~> 0.10.0", runtime: false}]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end

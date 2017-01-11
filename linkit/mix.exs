defmodule Linkit.Mixfile do
  use Mix.Project

  @target "linkit"

  def project do
    [app: :linkit,
     version: "0.0.1",
     target: @target,
     archives: [nerves_bootstrap: "0.2"],
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps() ++ system()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Linkit, []},
     applications: [:nerves, :logger, :nerves_uart, :firmata, :elixir_ale]]
  end

  def deps do
    [{:nerves, "~> 0.3.0"},
     {:nerves_uart, ">= 0.0.0"},
     {:elixir_ale, github: "fhunleth/elixir_ale"},
     {:firmata, github: "kfatehi/firmata"},
     {:nerves_system, path: "../../nerves_system", override: true},
     {:nerves_toolchain, path: "../../nerves_toolchain", override: true},
     {:relx, github: "erlware/relx", override: true}]
  end

  def system do
    [{:nerves_system_linkit, github: "nerves-project/nerves_system_linkit", branch: "pre"}]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end

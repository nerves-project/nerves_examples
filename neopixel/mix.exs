defmodule Neopixel.Mixfile do
  use Mix.Project

  @target System.get_env("MIX_TARGET") || "host"

  Mix.shell.info([:green, """
  Env
    MIX_TARGET:   #{@target}
    MIX_ENV:      #{Mix.env}
  """, :reset])

  def project do
    [app: :neopixel,
     version: "0.1.0",
     elixir: "~> 1.4.0",
     target: @target,
     archives: [nerves_bootstrap: "~> 0.3.0"],
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(@target),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application, do: application(@target)

  # Specify target specific application configurations
  # It is common that the application start function will start and supervise
  # applications which could cause the host to fail. Because of this, we only
  # invoke Neopixel.start/2 when running on a target.
  def application("host") do
    [extra_applications: [:logger]]
  end
  def application(_target) do
    [mod: {Neopixel, []},
     extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  def deps do
    [{:nerves, "~> 0.5.1", runtime: false}] ++
    deps(@target)
  end

  # Specify target specific dependencies
  def deps("host"), do: []
  def deps(target) do
    [ system(target),
      {:nerves_runtime, "~> 0.1.0"},
      {:nerves_neopixel, "~> 0.3.0"},
    ]
  end

  # Specify the version of the System to use for each target
  def system("rpi0"), do:       {:nerves_system_rpi0,       "~> 0.12.0", runtime: false}
  def system("rpi"), do:        {:nerves_system_rpi,        "~> 0.12.0", runtime: false}
  def system("rpi2"), do:       {:nerves_system_rpi2,       "~> 0.12.1", runtime: false}
  def system("rpi3"), do:       {:nerves_system_rpi3,       "~> 0.12.0", runtime: false}
  def system("qemu_arm"), do:   {:nerves_system_qemu_arm,   "~> 0.11.0", runtime: false}
  def system("bbb"), do:        Mix.raise "Sorry, this example only works on Raspberry Pi"
  def system("alix"), do:       Mix.raise "Sorry, this example only works on Raspberry Pi"
  def system("ag150"), do:      Mix.raise "Sorry, this example only works on Raspberry Pi"
  def system("galileo"), do:    Mix.raise "Sorry, this example only works on Raspberry Pi"
  def system("ev3"), do:        Mix.raise "Sorry, this example only works on Raspberry Pi"
  def system("linkit"), do:     Mix.raise "Sorry, this example only works on Raspberry Pi"
  def system(target), do:       Mix.raise "Unknown MIX_TARGET: #{target}"

  # We do not invoke the Nerves Env when running on the Host
  def aliases("host"), do: []
  def aliases(_target) do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end

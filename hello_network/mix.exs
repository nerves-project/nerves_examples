defmodule HelloNetwork.Mixfile do
  use Mix.Project

  @target System.get_env("MIX_TARGET") || "host"

  Mix.shell.info([:green, """
  Mix environment
    MIX_TARGET:   #{@target}
    MIX_ENV:      #{Mix.env}
  """, :reset])

  def project do
    [app: :hello_network,
     version: "0.3.0",
     elixir: "~> 1.4",
     target: @target,
     archives: [nerves_bootstrap: "~> 0.6"],
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     lockfile: "mix.lock.#{@target}",
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
  # invoke HelloNetwork.start/2 when running on a target.
  def application("host") do
    [extra_applications: [:logger]]
  end
  def application(_target) do
    [mod: {HelloNetwork, []},
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
    [{:nerves, "~> 0.7", runtime: false}] ++
    deps(@target)
  end

  # Specify target specific dependencies
  def deps("host"), do: []
  def deps(target) do
    [ system(target),
      {:bootloader, "~> 0.1"},
      {:nerves_runtime, "~> 0.4"},
      {:nerves_network, "~> 0.3"},
    ]
  end

  # Specify the version of the System to use for each target
  def system("rpi0"), do:       {:nerves_system_rpi0,       "~> 0.17.0", runtime: false}
  def system("rpi"), do:        {:nerves_system_rpi,        "~> 0.16.0", runtime: false}
  def system("rpi2"), do:       {:nerves_system_rpi2,       "~> 0.16.0", runtime: false}
  def system("rpi3"), do:       {:nerves_system_rpi3,       "~> 0.16.0", runtime: false}
  def system("bbb"), do:        {:nerves_system_bbb,        "~> 0.16.0", runtime: false}
  def system("ev3"), do:        {:nerves_system_ev3,        "~> 0.11.0", runtime: false}
  def system("linkit"), do:     {:nerves_system_linkit,     "~> 0.14.0", runtime: false}
  def system("qemu_arm"), do:   {:nerves_system_qemu_arm,   "~> 0.12.0", runtime: false}
  def system(target), do:       Mix.raise "Unknown MIX_TARGET: #{target}"

  # We do not invoke the Nerves Env when running on the Host
  def aliases("host"), do: []
  def aliases(_target) do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end

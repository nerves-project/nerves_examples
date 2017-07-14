defmodule HelloWifi.Mixfile do
  use Mix.Project

  @target System.get_env("MIX_TARGET") || "host"

  Mix.shell.info([:green, """
  Env
    MIX_TARGET:   #{@target}
    MIX_ENV:      #{Mix.env}
  """, :reset])

  def project do
    [app: :hello_wifi,
     version: "0.1.0",
     elixir: "~> 1.4.0",
     target: @target,
     archives: [nerves_bootstrap: "~> 0.5"],
     kernel_modules: kernel_modules(@target),
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
  # invoke HelloWifi.start/2 when running on a target.
  def application("host") do
    [extra_applications: [:logger]]
  end
  def application(_target) do
    [mod: {HelloWifi, []},
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
    [{:nerves, "~> 0.6.1", runtime: false}] ++
    deps(@target)
  end

  # Specify target specific dependencies
  def deps("host"), do: []
  def deps(target) do
    [ system(target),
      {:nerves_runtime, "~> 0.1.0"},
      {:nerves_interim_wifi, "~> 0.2.0"},
    ]
  end

  # Specify the version of the System to use for each target
  def system("rpi0"), do:       {:nerves_system_rpi0,       "~> 0.15.0", runtime: false}
  def system("rpi"), do:        {:nerves_system_rpi,        "~> 0.13.0", runtime: false}
  def system("rpi2"), do:       {:nerves_system_rpi2,       "~> 0.13.0", runtime: false}
  def system("rpi3"), do:       {:nerves_system_rpi3,       "~> 0.13.0", runtime: false}
  def system("bbb"), do:        {:nerves_system_bbb,        "~> 0.13.0", runtime: false}
  def system("alix"), do:       {:nerves_system_alix,       "~> 0.7.0",  runtime: false}
  def system("ag150"), do:      {:nerves_system_ag150,      "~> 0.7.0",  runtime: false}
  def system("galileo"), do:    {:nerves_system_galileo,    "~> 0.7.0",  runtime: false}
  def system("ev3"), do:        {:nerves_system_ev3,        "~> 0.11.0", runtime: false}
  def system("linkit"), do:     {:nerves_system_linkit,     "~> 0.12.0", runtime: false}
  def system("qemu_arm"), do:   {:nerves_system_qemu_arm,   "~> 0.11.0", runtime: false}
  def system(target), do:       Mix.raise "Unknown MIX_TARGET: #{target}"

  # We do not invoke the Nerves Env when running on the Host
  def aliases("host"), do: []
  def aliases(_target) do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

  def kernel_modules("rpi0"), do: ["brcmfmac"]
  def kernel_modules("rpi3"), do: ["brcmfmac"]
  def kernel_modules("rpi2"), do: ["8192cu"]
  def kernel_modules("rpi"), do: ["8192cu"]
  def kernel_modules("linkit"), do: ["mt7603e"]
  def kernel_modules(_), do: []

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end

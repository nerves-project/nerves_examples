defmodule HelloZig.MixProject do
  use Mix.Project

  @app :hello_zig
  @version "0.2.0"
  @all_targets [
    :rpi,
    :rpi0,
    :rpi2,
    :rpi3,
    :rpi3a,
    :rpi4,
    :bbb,
    :osd32mp1,
    :x86_64,
    :grisp2,
    :mangopi_mq_pro
  ]

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.14",
      archives: [nerves_bootstrap: "~> 1.10"],
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [{@app, release()}],
      preferred_cli_target: [run: :host, test: :host]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {HelloZig.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Dependencies for all targets
      {:nerves, "~> 1.10", runtime: false},
      {:shoehorn, "~> 0.9.0"},
      {:ring_logger, "~> 0.11.0"},
      {:toolshed, "~> 0.4.0"},
      {:zigler, "~> 0.11.0", runtime: false},

      # Dependencies for all targets except :host
      {:nerves_runtime, "~> 0.13.0", targets: @all_targets},
      {:nerves_pack, "~> 0.7.0", targets: @all_targets},

      # Dependencies for specific targets
      {:nerves_system_rpi, "~> 1.14", runtime: false, targets: :rpi},
      {:nerves_system_rpi0, "~> 1.14", runtime: false, targets: :rpi0},
      {:nerves_system_rpi2, "~> 1.14", runtime: false, targets: :rpi2},
      {:nerves_system_rpi3, "~> 1.14", runtime: false, targets: :rpi3},
      {:nerves_system_rpi3a, "~> 1.14", runtime: false, targets: :rpi3a},
      {:nerves_system_rpi4, "~> 1.14", runtime: false, targets: :rpi4},
      {:nerves_system_bbb, "~> 2.9", runtime: false, targets: :bbb},
      {:nerves_system_osd32mp1, "~> 0.5", runtime: false, targets: :osd32mp1},
      {:nerves_system_x86_64, "~> 1.14", runtime: false, targets: :x86_64},
      {:nerves_system_grisp2, "~> 0.3", runtime: false, targets: :grisp2},
      {:nerves_system_mangopi_mq_pro, "~> 0.4", runtime: false, targets: :mangopi_mq_pro}
    ]
  end

  def release do
    [
      overwrite: true,
      # Erlang distribution is not started automatically.
      # See https://hexdocs.pm/nerves_pack/readme.html#erlang-distribution
      cookie: "#{@app}_cookie",
      include_erts: &Nerves.Release.erts/0,
      steps: [&Nerves.Release.init/1, :assemble],
      strip_beams: Mix.env() == :prod or [keep: ["Docs"]]
    ]
  end
end

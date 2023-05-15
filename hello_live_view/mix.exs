defmodule HelloLiveView.MixProject do
  use Mix.Project

  @app :hello_live_view
  @version "0.1.0"
  @all_targets [:rpi, :rpi0, :rpi2, :rpi3, :rpi3a, :rpi4, :bbb, :osd32mp1, :x86_64, :grisp2]

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      archives: [nerves_bootstrap: "~> 1.11"],
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      releases: [{@app, release()}],
      preferred_cli_target: [run: :host, test: :host]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {HelloLiveView.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # Initial pheonix deps
      {:phoenix, "~> 1.7.2"},
      {:phoenix_view, "~> 2.0"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.18.18"},
      {:floki, ">= 0.30.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.7"},
      {:esbuild, "~> 0.4", runtime: Mix.env() == :dev},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.18"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},

      # Additional ui deps
      {:tailwind, "~> 0.1", runtime: Mix.env() == :dev},

      # Dependencies for all targets
      {:nerves, "~> 1.7.16 or ~> 1.8.0 or ~> 1.9.0", runtime: false},
      {:shoehorn, "~> 0.9.1"},
      {:ring_logger, "~> 0.8.5"},
      {:toolshed, "~> 0.2.26"},

      # Dependencies for all targets except :host
      {:nerves_runtime, "~> 0.13.0", targets: @all_targets},
      {:nerves_pack, "~> 0.7.0", targets: @all_targets},

      # Dependencies for specific targets
      # NOTE: It's generally low risk and recommended to follow minor version
      # bumps to Nerves systems. Since these include Linux kernel and Erlang
      # version updates, please review their release notes in case
      # changes to your application are needed.
      {:nerves_system_rpi, "~> 1.19", runtime: false, targets: :rpi},
      {:nerves_system_rpi0, "~> 1.19", runtime: false, targets: :rpi0},
      {:nerves_system_rpi2, "~> 1.19", runtime: false, targets: :rpi2},
      {:nerves_system_rpi3, "~> 1.19", runtime: false, targets: :rpi3},
      {:nerves_system_rpi3a, "~> 1.19", runtime: false, targets: :rpi3a},
      {:nerves_system_rpi4, "~> 1.19", runtime: false, targets: :rpi4},
      {:nerves_system_bbb, "~> 2.14", runtime: false, targets: :bbb},
      {:nerves_system_osd32mp1, "~> 0.10", runtime: false, targets: :osd32mp1},
      {:nerves_system_x86_64, "~> 1.19", runtime: false, targets: :x86_64},
      {:nerves_system_grisp2, "~> 0.3", runtime: false, targets: :grisp2}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"]
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

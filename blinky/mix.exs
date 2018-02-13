defmodule Blinky.MixProject do
  use Mix.Project

  @target System.get_env("MIX_TARGET") || "host"

  Mix.shell().info([
    :green,
    """
    Mix environment
      MIX_TARGET:   #{@target}
      MIX_ENV:      #{Mix.env()}
    """,
    :reset
  ])

  def project do
    [
      app: :blinky,
      version: "0.1.0",
      elixir: "~> 1.4",
      target: @target,
      archives: [nerves_bootstrap: "~> 0.7"],
      deps_path: "deps/#{@target}",
      build_path: "_build/#{@target}",
      lockfile: "mix.lock.#{@target}",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      aliases: aliases(@target),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application, do: application(@target)

  # Specify target specific application configurations
  # It is common that the application start function will start and supervise
  # applications which could cause the host to fail. Because of this, we only
  # invoke Blinky.start/2 when running on a target.
  def application("host") do
    [extra_applications: [:logger]]
  end

  def application(_target) do
    [mod: {Blinky.Application, []}, extra_applications: [:logger]]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [{:nerves, "~> 0.9", runtime: false}] ++ deps(@target)
  end

  # Specify target specific dependencies
  defp deps("host"), do: []

  defp deps(target) do
    [
      {:shoehorn, "~> 0.2"},
      {:nerves_runtime, "~> 0.5"},
      {:nerves_leds, "~> 0.8"}
    ] ++ system(target)
  end

  defp system("rpi"), do: [{:nerves_system_rpi, "~> 0.20.0", runtime: false}]
  defp system("rpi0"), do: [{:nerves_system_rpi0, "~> 0.21.0", runtime: false}]
  defp system("rpi2"), do: [{:nerves_system_rpi2, "~> 0.20.0", runtime: false}]
  defp system("rpi3"), do: [{:nerves_system_rpi3, "~> 0.20.0", runtime: false}]
  defp system("bbb"), do: [{:nerves_system_bbb, "~> 0.20.0", runtime: false}]
  defp system("ev3"), do: [{:nerves_system_ev3, "~> 0.15.0", runtime: false}]
  defp system("qemu_arm"), do: [{:nerves_system_qemu_arm, "~> 0.16.0", runtime: false}]
  defp system("x86_64"), do: [{:nerves_system_x86_64, "~> 0.5.0", runtime: false}]
  defp system(target), do: Mix.raise("Unknown MIX_TARGET: #{target}")

  # We do not invoke the Nerves Env when running on the Host
  defp aliases("host"), do: []

  defp aliases(_target) do
    [
      # Add custom mix aliases here
    ]
    |> Nerves.Bootstrap.add_aliases()
  end
end

defmodule HelloWifi.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi3"

  def project do
    [app: :hello_wifi,
     version: "0.0.1",
     elixir: "~> 1.3",
     archives: [nerves_bootstrap: "~> 0.2"],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     target: @target,
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     aliases: aliases(),
     deps: deps() ++ system(@target)]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {HelloWifi, []},
     applications: [:logger, :nerves_interim_wifi]]
  end

  defp deps do
    [{:nerves, "~> 0.3.0"},
     {:nerves_interim_wifi, "~> 0.0.2"}]
  end

  def system(target) do
    [
     {:"nerves_system_#{target}", "~> 0.6"}
    ]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end

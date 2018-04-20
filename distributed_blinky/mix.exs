defmodule DistributedBlinky.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi3"
  @host_id System.get_env("NERVES_HOST_ID") || "2"

  def project do
    [app: :distributed_blinky,
     version: "0.0.1",
     target: @target,
     host_id: @host_id,
     archives: [nerves_bootstrap: "0.1.2"],
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps ++ system(@target)]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {DistributedBlinky, []},
     applications: [:nerves, :logger, :phoenix_pubsub]]
  end

  def deps do
    [
      {:nerves, "~> 0.3.0"},
      {:nerves_io_led, github: "nerves-project/nerves_io_led"},
      {:nerves_networking, github: "nerves-project/nerves_networking"},
      {:phoenix_pubsub, "~> 1.0.0-rc.0"}
    ]
  end

  def system(target) do
    [{:"nerves_system_#{target}", ">= 0.0.0"}]
  end

  def aliases do
    [ "compile": ["preprocess", "compile"],
      "deps.precompile": ["nerves.precompile", "deps.precompile"],
      "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end

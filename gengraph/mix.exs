defmodule Gengraph.MixProject do
  use Mix.Project

  def project do
    [
      app: :gengraph,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: [main_module: Gengraph]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:gnuplot, "~> 1.19.0"},
      {:csv, "~> 2.3.0"},
    ]
  end
end

defmodule BahnEx.Mixfile do
  use Mix.Project

  def project do
    [
      app: :bahn_ex,
      version: "1.0.1",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/pfitz/bahn_ex",
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
      {:httpoison, "~> 0.13.0"},
      {:poison, "~> 3.1"},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:mock, "~> 0.2.0", only: :test},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp description do
  """
  An Elixir wrapper for the Deutsche Bahn (DB) Fahrplan API.
  """
  end

  defp package do
    [
      name: :bahn_ex,
      maintainers: ["Friedrich Pfitzmann"],
      licenses: ["MIT License"],
      links: %{"GitHub" => "https://github.com/pfitz/bahn_ex"},
    ]
  end
end

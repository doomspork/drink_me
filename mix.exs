defmodule DrinkMe.Mixfile do
  use Mix.Project

  def project do
    [app: :drink_me,
      version: "0.0.1",
      elixir: "~> 1.0",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix] ++ Mix.compilers,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {DrinkMe, []},
      applications: [:phoenix, :cowboy, :logger,
        :phoenix_ecto, :postgrex, :httpotion]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:cowboy, "~> 1.0"},
      {:erlcloud, git: "https://github.com/gleber/erlcloud", branch: "master"},
      {:httpotion, "~> 2.0.0"},
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.1"},
      {:jsx, "~> 2.6", override: true},
      {:phoenix, "~> 0.13"},
      {:phoenix_ecto, "~> 0.4"},
      {:phoenix_html, "~> 1.0"},
      {:phoenix_live_reload, "~> 0.4"},
      {:postgrex, "~> 0.8"}
    ]
  end
end

defmodule Mongodb.Mixfile do
  use Mix.Project

  @version "0.5.3"

  def project do
    [
      app: :mongodb,
      version: @version,
      elixirc_paths: elixirc_paths(Mix.env()),
      elixir: "~> 1.5",
      name: "Mongodb",
      deps: deps(),
      docs: docs(),
      description: description(),
      package: package(),
      dialyzer: [
        flags: [:underspecs, :unknown, :unmatched_returns],
        plt_add_apps: [:logger, :connection, :db_connection, :mix, :elixir, :ssl, :public_key],
        plt_add_deps: :transitive
      ],
      consolidate_protocols: Mix.env() != :test
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [
      mod: {Mongo.App, []},
      env: [],
      extra_applications: [:crypto, :logger, :ssl],
      registered: [
        Mongo.PBKDF2Cache,
        Mongo.Session.Supervisor,
        Mongo.Events,
        Mongo.IdServer,
        Mongo.SessionPool
      ]
    ]
  end

  defp deps do
    [
      {:db_connection, "~> 2.4"},
      {:decimal, "~> 2.0"},
      {:jason, "~> 1.2", only: :test},
      {:ex_doc, "~> 0.24.2 ", only: :dev},
      {:earmark, ">= 0.0.0", only: :dev},
      {:dialyxir, "~> 1.1", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"],
      source_ref: "v#{@version}",
      source_url: "https://github.com/ankhers/mongodb"
    ]
  end

  defp description do
    "MongoDB driver for Elixir"
  end

  defp package do
    [
      maintainers: ["Eric Meadows-Jönsson", "Justin Wood"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/ankhers/mongodb"}
    ]
  end
end

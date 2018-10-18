defmodule ExApiGateway.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_api_gateway,
      version: "0.1.0",
      elixir: "~> 1.7",
      deps: deps(),
      escript: escript(),
      description: "sample API gateway"
    ]
  end

  def application do
    [
      applications: applications(Mix.env),
      mod: {ExApiGateway.Application, []}
    ]
  end

  defp applications(:dev), do: applications(:all) ++ [:remix]
  defp applications(_all), do: [:logger, :rackla, :cowboy]

  defp deps do
    [
      {:rackla, "~> 1.2"},
      {:cowboy, "~> 1.0"},
      {:remix, "~> 0.0", only: :dev}
    ]
  end

  def escript do
    [main_module: ExApiGateway.Application]
  end
end

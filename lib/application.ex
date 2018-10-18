defmodule ExApiGateway.Application do
  @moduledoc false

  use Application

  def main(_args) do
    :timer.sleep(:infinity)
  end

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    
    port = Application.get_env(:ex_api_gateway, :port, 4000)
    port = if is_binary(port), do: String.to_integer(port), else: port

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, ExApiGateway.Router, [], [port: port])
    ]

    opts = [strategy: :one_for_one, name: ExApiGateway.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
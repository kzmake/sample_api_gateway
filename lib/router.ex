defmodule ExApiGateway.Router do
  @moduledoc false

  use Plug.Router
  import Rackla

  plug :match
  plug :dispatch

  get "/ping", host: "jp-east-1.computing." do
    "Pong computing"
    |> just
    |> response
  end

  get "/ping", host: "api.github.com" do
    "Pong github"
    |> just
    |> response
  end

  get "/ping", host: "localhost" do
    "Pong localhost"
    |> just
    |> response
  end

  get "/ping" do
    "No matching host, #{conn.host}"
    |> just
    |> response
  end

  match "/api/", host: "jp-east-1.computing." do
    host = conn.host
    path = conn.request_path
    query_string = conn.query_string
    method = conn.method

    IO.inspect(%{method: method, url: "https://#{host}#{path}", body: "#{query_string}"})

    %{method: method, url: "https://#{host}#{path}", body: "#{query_string}"}
    |> request
    |> response
  end

  match "/*glob", host: "api.github.com" do
    host = conn.host
    path = conn.request_path
    query_string = conn.query_string
    method = conn.method

    IO.inspect("https://#{host}#{path}")

    %{method: method, url: "https://#{host}#{path}", body: "#{query_string}"}
    |> request
    |> response
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
defmodule ExApiGateway.Router do
  @moduledoc false

  use Plug.Router
  import Rackla

  plug :match
  plug :dispatch

  get "/hello" do
    "Hello, world!"
    |> just
    |> response
  end

  get "/computing/" do
    host = conn.host
    query_string = conn.query_string

    IO.inspect("https://#{host}/api/?#{query_string}")

    %{method: :post, url: "https://#{host}/api/", body: "#{query_string}"}
    |> request
    |> response
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
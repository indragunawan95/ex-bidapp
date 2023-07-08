defmodule ExbidappWeb.HealthController do
  use ExbidappWeb, :controller

  def health(conn, _params) do
    conn
    |> put_status(200)
    |> json(%{"status" => "healthy"})
  end
end

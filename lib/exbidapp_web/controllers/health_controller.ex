defmodule ExbidappWeb.HealthController do
  @moduledoc """
    The Health Check Controller.
  """
  use ExbidappWeb, :controller

  def health(conn, _params) do
    conn
    |> put_status(200)
    |> json(%{"status" => "healthy"})
  end
end

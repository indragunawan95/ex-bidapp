defmodule ExbidappWeb.Router do
  use ExbidappWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExbidappWeb do
    pipe_through :api
    get "/health", HealthController, :health
  end
end
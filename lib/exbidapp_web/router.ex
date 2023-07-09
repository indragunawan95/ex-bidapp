defmodule ExbidappWeb.Router do
  use ExbidappWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExbidappWeb do
    pipe_through :api
    get "/health", HealthController, :health

    resources "/users", UserController, except: [:new, :edit]
    resources "/products", ProductController, except: [:new, :edit]
    resources "/bids", BidController, except: [:new, :edit]
  end
end

defmodule ExbidappWeb.BidController do
  use ExbidappWeb, :controller

  alias Exbidapp.Bids
  alias Exbidapp.Bids.Bid

  action_fallback ExbidappWeb.FallbackController

  def index(conn, _params) do
    bids = Bids.list_bids()
    render(conn, :index, bids: bids)
  end

  def create(conn, %{"bid" => bid_params}) do
    with {:ok, %Bid{} = bid} <- Bids.create_bid(bid_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/bids/#{bid}")
      |> render(:show, bid: bid)
    end
  end

  def show(conn, %{"id" => id}) do
    bid = Bids.get_bid!(id)
    render(conn, :show, bid: bid)
  end
end

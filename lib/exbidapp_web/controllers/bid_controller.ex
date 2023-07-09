defmodule ExbidappWeb.BidController do
  @moduledoc """
    The Bid Controller.
  """
  use ExbidappWeb, :controller

  alias Exbidapp.Bids
  alias Exbidapp.Bids.Bid

  action_fallback ExbidappWeb.FallbackController

  @doc """
    Handler for list of bids
  """
  def index(conn, _params) do
    bids = Bids.list_bids()
    render(conn, :index, bids: bids)
  end

  @doc """
    Handler for creating a bid
  """
  def create(conn, %{"bid" => bid_params}) do
    with {:ok, %Bid{} = bid} <- Bids.create_bid(bid_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/bids/#{bid}")
      |> render(:show, bid: bid)
    end
  end

  @doc """
    Handler for showing a bid
  """
  def show(conn, %{"id" => id}) do
    bid = Bids.get_bid!(id)
    render(conn, :show, bid: bid)
  end
end

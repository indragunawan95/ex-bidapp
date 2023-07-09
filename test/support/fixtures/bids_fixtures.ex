defmodule Exbidapp.BidsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Exbidapp.Bids` context.
  """
  alias Exbidapp.{UsersFixtures, ProductsFixtures}

  @doc """
  Generate a bid.
  """
  def bid_fixture(attrs \\ %{}) do
    bidder = UsersFixtures.user_fixture()
    product = ProductsFixtures.product_fixture()

    {:ok, bid} =
      attrs
      |> Enum.into(%{
        price: "120.5",
        product_id: product.id,
        bidder_id: bidder.id
      })
      |> Exbidapp.Bids.create_bid()

    bid
  end
end

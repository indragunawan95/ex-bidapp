defmodule Exbidapp.BidsTest do
  use Exbidapp.DataCase

  alias Exbidapp.Bids

  describe "bids" do
    alias Exbidapp.Bids.Bid

    import Exbidapp.BidsFixtures
    import Exbidapp.UsersFixtures
    import Exbidapp.ProductsFixtures

    @invalid_attrs %{price: nil}

    test "list_bids/0 returns all bids" do
      bid = bid_fixture()
      assert Bids.list_bids() == [bid]
    end

    test "get_bid!/1 returns the bid with given id" do
      bid = bid_fixture()
      assert Bids.get_bid!(bid.id) == bid
    end

    test "create_bid/1 with valid data creates a bid" do
      bidder = user_fixture()
      product = product_fixture()
      valid_attrs = %{price: "120.5", product_id: product.id, bidder_id: bidder.id}

      assert {:ok, %Bid{} = bid} = Bids.create_bid(valid_attrs)
      assert bid.price == Decimal.new("120.5")
    end

    test "create_bid/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bids.create_bid(@invalid_attrs)
    end

    test "update_bid/2 with valid data updates the bid" do
      bid = bid_fixture()
      update_attrs = %{price: "456.7"}

      assert {:ok, %Bid{} = bid} = Bids.update_bid(bid, update_attrs)
      assert bid.price == Decimal.new("456.7")
    end

    test "update_bid/2 with invalid data returns error changeset" do
      bid = bid_fixture()
      assert {:error, %Ecto.Changeset{}} = Bids.update_bid(bid, @invalid_attrs)
      assert bid == Bids.get_bid!(bid.id)
    end

    test "delete_bid/1 deletes the bid" do
      bid = bid_fixture()
      assert {:ok, %Bid{}} = Bids.delete_bid(bid)
      assert_raise Ecto.NoResultsError, fn -> Bids.get_bid!(bid.id) end
    end

    test "change_bid/1 returns a bid changeset" do
      bid = bid_fixture()
      assert %Ecto.Changeset{} = Bids.change_bid(bid)
    end
  end
end

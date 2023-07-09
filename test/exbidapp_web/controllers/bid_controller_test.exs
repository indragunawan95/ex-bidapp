defmodule ExbidappWeb.BidControllerTest do
  use ExbidappWeb.ConnCase

  import Exbidapp.UsersFixtures
  import Exbidapp.ProductsFixtures

  @invalid_attrs %{price: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all bids", %{conn: conn} do
      conn = get(conn, ~p"/api/bids")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create bid" do
    test "renders bid when data is valid", %{conn: conn} do
      bidder = user_fixture()
      product = product_fixture()

      attrs = %{
        price: "120.5",
        product_id: product.id,
        bidder_id: bidder.id
      }

      conn = post(conn, ~p"/api/bids", bid: attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/bids/#{id}")

      assert %{
               "id" => ^id,
               "price" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/bids", bid: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end

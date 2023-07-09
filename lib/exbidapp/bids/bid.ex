defmodule Exbidapp.Bids.Bid do
  use Ecto.Schema
  import Ecto.Changeset
  alias Exbidapp.Products.Product
  alias Exbidapp.Users.User

  schema "bids" do
    field :price, :decimal

    belongs_to :product, Product,
      references: :id,
      foreign_key: :product_id,
      type: :id

    belongs_to :bidder, User,
      references: :id,
      foreign_key: :bidder_id,
      type: :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bid, attrs) do
    bid
    |> cast(attrs, [:price, :product_id, :bidder_id])
    |> validate_required([:price, :product_id, :bidder_id])
  end
end

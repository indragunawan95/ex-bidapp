defmodule Exbidapp.Products.Product do
  @moduledoc """
    This module is schema for Product Entity
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Exbidapp.Users.User

  schema "products" do
    field :description, :string
    field :title, :string
    field :start_price, :decimal

    belongs_to :owner, User,
      references: :id,
      foreign_key: :owner_id,
      type: :id

    belongs_to :buyer, User,
      references: :id,
      foreign_key: :buyer_id,
      type: :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:title, :description, :start_price, :owner_id, :buyer_id])
    |> validate_required([:title, :description, :start_price, :owner_id])
  end
end

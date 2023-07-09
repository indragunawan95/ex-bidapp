defmodule Exbidapp.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Exbidapp.Products` context.
  """
  alias Exbidapp.UsersFixtures

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    user = UsersFixtures.user_fixture()

    {:ok, product} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title",
        start_price: "120.5",
        owner_id: user.id
      })
      |> Exbidapp.Products.create_product()

    product
  end
end

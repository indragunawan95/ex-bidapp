defmodule Exbidapp.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Exbidapp.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title",
        start_price: "120.5"
      })
      |> Exbidapp.Products.create_product()

    product
  end
end

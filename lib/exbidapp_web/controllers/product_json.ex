defmodule ExbidappWeb.ProductJSON do
  alias Exbidapp.Products.Product

  @doc """
  Renders a list of products.
  """
  def index(%{products: products}) do
    %{data: for(product <- products, do: data(product))}
  end

  @doc """
  Renders a single product.
  """
  def show(%{product: product}) do
    %{data: data(product)}
  end

  defp data(%Product{} = product) do
    %{
      id: product.id,
      title: product.title,
      description: product.description,
      start_price: product.start_price
    }
  end
end

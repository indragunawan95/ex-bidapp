defmodule Exbidapp.Bids do
  @moduledoc """
  The Bids context.
  This module where all Business Logic related to Bid located. Bid
  """

  import Ecto.Query, warn: false
  alias Exbidapp.Repo
  alias Ecto.Multi

  alias Exbidapp.Bids.Bid
  alias Exbidapp.Products
  require Logger

  @doc """
  Returns the list of bids.

  ## Examples

      iex> list_bids()
      [%Bid{}, ...]

  """
  def list_bids do
    Repo.all(Bid)
  end

  @doc """
  Gets a single bid.

  Raises `Ecto.NoResultsError` if the Bid does not exist.

  ## Examples

      iex> get_bid!(123)
      %Bid{}

      iex> get_bid!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bid!(id), do: Repo.get!(Bid, id)

  @doc """
  Creates a bid.

  ## Examples

      iex> create_bid(%{field: value})
      {:ok, %Bid{}}

      iex> create_bid(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bid(attrs \\ %{}) do
    %Bid{}
    |> Bid.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bid.

  ## Examples

      iex> update_bid(bid, %{field: new_value})
      {:ok, %Bid{}}

      iex> update_bid(bid, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bid(%Bid{} = bid, attrs) do
    bid
    |> Bid.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bid.

  ## Examples

      iex> delete_bid(bid)
      {:ok, %Bid{}}

      iex> delete_bid(bid)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bid(%Bid{} = bid) do
    Repo.delete(bid)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bid changes.

  ## Examples

      iex> change_bid(bid)
      %Ecto.Changeset{data: %Bid{}}

  """
  def change_bid(%Bid{} = bid, attrs \\ %{}) do
    Bid.changeset(bid, attrs)
  end

  @doc """
    Get last bid for specific product id
  """
  def last_bid(product_id) do
    from(b in Bid,
      where: b.product_id == ^product_id,
      order_by: [desc: :inserted_at]
    )
    |> Repo.one()
  end

  @doc """
    Logic for submit bid
  """
  def submit_bid(attrs \\ %{}) do
    Multi.new()
    |> Multi.run(:get_product, fn _, _ ->
      Products.get_product!(attrs["product_id"])
      |> case do
        nil ->
          {:error, "product is invalid"}

        product ->
          {:ok, product}
      end
    end)
    |> Multi.run(:validate_price, fn _, %{get_product: product} ->
      last_bid(product.id)
      |> case do
        nil ->
          {:ok, "first bid"}

        bid ->
          current_price = Decimal.new(attrs["price"])

          Decimal.compare(bid.price, current_price)
          |> case do
            :gt ->
              {:ok, "validation pass"}

            _ ->
              {:error, "validation error"}
          end
      end
    end)
    |> Multi.run(:create_bid, fn _, _ ->
      create_bid(attrs)
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{create_bid: bid}} ->
        {:ok, bid}

      {:error, steps, message, _} ->
        Logger.error("submit_bid error at steps: #{steps} #{inspect(message)}")
        {:error, message}
    end
  end
end

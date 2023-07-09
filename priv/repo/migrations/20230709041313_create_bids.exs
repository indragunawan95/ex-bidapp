defmodule Exbidapp.Repo.Migrations.CreateBids do
  use Ecto.Migration

  def change do
    create table(:bids) do
      add :price, :decimal
      add :product_id, references(:products, on_delete: :nothing)
      add :bidder_id, references(:users, on_delete: :nothing)

      timestamps(type: :timestamptz)
    end

    create index(:bids, [:product_id])
    create index(:bids, [:bidder_id])
  end
end

defmodule Exbidapp.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :title, :string
      add :description, :string
      add :start_price, :decimal
      add :owner_id, references(:users, on_delete: :nothing), null: false
      add :buyer_id, references(:users, on_delete: :nothing)

      timestamps(type: :timestamptz)
    end

    create index(:products, [:owner_id])
    create index(:products, [:buyer_id])
  end
end

defmodule Exbidapp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :password_hash, :string

      timestamps(type: :timestamptz)
    end
  end
end

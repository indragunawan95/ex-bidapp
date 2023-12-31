defmodule Exbidapp.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Exbidapp.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        username: "some username",
        password_hash: "some password_hash"
      })
      |> Exbidapp.Users.create_user()

    user
  end
end

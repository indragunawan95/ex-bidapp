defmodule ExbidappWeb.UserController do
  @moduledoc """
    The User Controller.
  """
  use ExbidappWeb, :controller

  alias Exbidapp.Users
  alias Exbidapp.Users.User

  action_fallback ExbidappWeb.FallbackController

  @doc """
    Handler for creating a user
  """
  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    end
  end

  @doc """
    Handler for showing a user
  """
  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, :show, user: user)
  end

  @doc """
    Handler for updating a product
  """
  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end
end

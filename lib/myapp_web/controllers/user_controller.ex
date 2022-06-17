defmodule MyappWeb.UserController do
  use MyappWeb, :controller

  alias Myapp.Account.User

  action_fallback MyappWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Myapp.Account.create_user(params) do
      conn
      |> put_status(:created)
      |> render("show.json", %{user: user})
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Myapp.Account.get_user(id) do
      conn
      |> render("show.json", %{user: user})
    end
  end

end

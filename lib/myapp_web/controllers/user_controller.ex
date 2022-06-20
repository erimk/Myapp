defmodule MyappWeb.UserController do
  use MyappWeb, :controller

  alias Myapp.Account
  alias Myapp.Account.User

  action_fallback MyappWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Account.create_user(params) do
      conn
      |> put_status(:created)
      |> render("show.json", %{user: user})
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Account.get_user(id) do
      render(conn, "show.json", %{user: user})
    end
  end

  def index(conn, _params), do: render(conn, "index.json", %{users: Account.list_users})
end

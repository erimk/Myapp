defmodule MyappWeb.UserController do
  use MyappWeb, :controller

  alias Myapp.Account

  action_fallback MyappWeb.FallbackController

  def create(conn, params) do
    with {:ok, user} <- Account.create_user(params) do
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

  def index(conn, _params), do: render(conn, "index.json", %{users: Account.list_users()})

  def update(conn, params) do
    with {:ok, user} <- Account.get_user(params["id"]),
         {:ok, neo_user} <- Account.update_user(user, params) do
      render(conn, "show.json", %{user: neo_user})
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, user} <- Account.get_user(id),
         {:ok, _user} <- Account.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end

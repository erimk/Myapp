defmodule MyappWeb.UserController do
  use MyappWeb, :controller

  action_fallback MyappWeb.FallbackController

  def create(conn, params) do
    with {:ok, user} <- Myapp.Account.create_user(params) do
      conn
      |> put_status(:created)
      |> render("show.json", %{user: user})
    end
  end

end

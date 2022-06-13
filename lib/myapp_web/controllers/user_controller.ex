defmodule MyappWeb.UserController do
  use MyappWeb, :controller

  def create(conn, params) do
    conn
    |> put_status(:created)
    |> json(%{ data: %{ id: 1, name: params["name"], email: params["email"]}})
  end

end

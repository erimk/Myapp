defmodule MyappWeb.FallbackController do
  use MyappWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(MyappWeb.ChangesetView)
    |> render("error.json", %{changeset: changeset})
  end

  def call(conn, {:error, _}) do
    conn
    |> put_status(:bad_request)
    |> put_view(MyappWeb.ErrorView)
    |> render(:"400")
  end

end

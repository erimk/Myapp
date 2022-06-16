defmodule MyappWeb.User.Controller do
  use MyappWeb.ConnCase, async: true

  import Myapp.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create" do
    test "returns ok when valid data", %{conn: conn} do
      params = params_for(:user)

      conn = post(conn, "/api/users" ,params)

      assert resp = json_response(conn, 201)["data"]
      assert resp["id"] != nil
      assert resp["name"] == params.name
      assert resp["email"] == params.email
    end

    test "returns ecto error when invalid email", %{conn: conn} do
      params = params_for(:user, %{email: nil})

      conn = post(conn, "/api/users", params)

      assert ["can't be blank"] = json_response(conn, 422)["errors"]["email"]
    end
  end

end

defmodule MyappWeb.User.Controller do
  use MyappWeb.ConnCase

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
  end

end

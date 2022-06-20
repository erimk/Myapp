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

  describe "show" do
    test "returns ok when valid data", %{conn: conn} do
      user = insert(:user)

      conn = get(conn, "/api/users/#{user.id}")

      assert resp = json_response(conn, 200)["data"]
      assert resp["id"] == user.id
      assert resp["name"] == user.name
      assert resp["email"] == user.email
    end

    test "returns error when invalid data", %{conn: conn} do
      conn = get(conn, "/api/users/0")

      assert json_response(conn, 404)["errors"]["detail"] == "Not Found"
    end
  end

  describe "index" do
    test "returns ok when valida data", %{conn: conn} do
      user = insert(:user)

      conn = get(conn, "/api/users")

      assert [resp] = json_response(conn, 200)["data"]
      assert resp["id"] == user.id
    end

    test "returns ok when valid users", %{conn: conn} do
      user = insert(:user) #|> IO.inspect()
      insert(:user) #|> IO.inspect()

      conn = get(conn, "/api/users")

      assert [resp, _resp2] = json_response(conn, 200)["data"]
      assert resp["id"] == user.id
    end
  end

end

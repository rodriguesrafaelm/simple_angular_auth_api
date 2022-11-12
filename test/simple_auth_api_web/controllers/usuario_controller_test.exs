defmodule SimpleAuthApiWeb.UsuarioControllerTest do
  use SimpleAuthApiWeb.ConnCase

  import SimpleAuthApi.ContasFixtures

  alias SimpleAuthApi.Contas.Usuario

  @create_attrs %{
    email: "some email",
    password: "some password",
    username: "some username"
  }
  @update_attrs %{
    email: "some updated email",
    password: "some updated password",
    username: "some updated username"
  }
  @invalid_attrs %{email: nil, password: nil, username: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all usuarios", %{conn: conn} do
      conn = get(conn, Routes.usuario_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create usuario" do
    test "renders usuario when data is valid", %{conn: conn} do
      conn = post(conn, Routes.usuario_path(conn, :create), usuario: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.usuario_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "email" => "some email",
               "password" => "some password",
               "username" => "some username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.usuario_path(conn, :create), usuario: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update usuario" do
    setup [:create_usuario]

    test "renders usuario when data is valid", %{conn: conn, usuario: %Usuario{id: id} = usuario} do
      conn = put(conn, Routes.usuario_path(conn, :update, usuario), usuario: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.usuario_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "email" => "some updated email",
               "password" => "some updated password",
               "username" => "some updated username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, usuario: usuario} do
      conn = put(conn, Routes.usuario_path(conn, :update, usuario), usuario: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete usuario" do
    setup [:create_usuario]

    test "deletes chosen usuario", %{conn: conn, usuario: usuario} do
      conn = delete(conn, Routes.usuario_path(conn, :delete, usuario))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.usuario_path(conn, :show, usuario))
      end
    end
  end

  defp create_usuario(_) do
    usuario = usuario_fixture()
    %{usuario: usuario}
  end
end

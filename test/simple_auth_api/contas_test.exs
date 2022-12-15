defmodule SimpleAuthApi.ContasTest do
  use SimpleAuthApi.DataCase

  alias SimpleAuthApi.Contas

  describe "usuarios" do
    alias SimpleAuthApi.Contas.Usuario

    import SimpleAuthApi.ContasFixtures

    @invalid_attrs %{email: nil, password: nil, username: nil}

    # test "list_usuarios/0 returns all usuarios" do
    #   usuario = usuario_fixture()
    #   assert Contas.list_usuarios() == [usuario]
    # end

    # test "get_usuario!/1 returns the usuario with given id" do
    #   usuario = usuario_fixture()
    #   assert Contas.get_usuario!(usuario.id) == usuario
    # end

    # test "create_usuario/1 with valid data creates a usuario" do
    #   valid_attrs = %{email: "some email", password: "some password", username: "some username"}

    #   assert {:ok, %Usuario{} = usuario} = Contas.create_usuario(valid_attrs)
    #   assert usuario.email == "some email"
    #   assert usuario.password == "some password"
    #   assert usuario.username == "some username"
    # end

    # test "create_usuario/1 with invalid data returns error changeset" do
    #   assert {:error, %Ecto.Changeset{}} = Contas.create_usuario(@invalid_attrs)
    # end

    # test "update_usuario/2 with valid data updates the usuario" do
    #   usuario = usuario_fixture()
    #   update_attrs = %{email: "some updated email", password: "some updated password", username: "some updated username"}

    #   assert {:ok, %Usuario{} = usuario} = Contas.update_usuario(usuario, update_attrs)
    #   assert usuario.email == "some updated email"
    #   assert usuario.password == "some updated password"
    #   assert usuario.username == "some updated username"
    # end

    # test "update_usuario/2 with invalid data returns error changeset" do
    #   usuario = usuario_fixture()
    #   assert {:error, %Ecto.Changeset{}} = Contas.update_usuario(usuario, @invalid_attrs)
    #   assert usuario == Contas.get_usuario!(usuario.id)
    # end

    # test "delete_usuario/1 deletes the usuario" do
    #   usuario = usuario_fixture()
    #   assert {:ok, %Usuario{}} = Contas.delete_usuario(usuario)
    #   assert_raise Ecto.NoResultsError, fn -> Contas.get_usuario!(usuario.id) end
    # end

    # test "change_usuario/1 returns a usuario changeset" do
    #   usuario = usuario_fixture()
    #   assert %Ecto.Changeset{} = Contas.change_usuario(usuario)
    # end

    test "pegar usuario pelo id" do
      usuario = usuario_fixture()
      assert Contas.get_user_by_id(usuario.id) == {:ok, usuario}
    end

    # test "adicionar novo usuario usando atributos" do
    #   usuario = novo_usuario_fixture()
    #   assert Contas.add_user(usuario) == {:ok, %Usuario{}}
    # end

  end
end

defmodule SimpleAuthApiWeb.UsuarioView do
  use SimpleAuthApiWeb, :view
  alias SimpleAuthApiWeb.UsuarioView

  def render("index.json", %{usuarios: usuarios}) do
    %{data: render_many(usuarios, UsuarioView, "usuario.json")}
  end

  def render("show.json", %{usuario: usuario}) do
    %{data: render_one(usuario, UsuarioView, "usuario.json")}
  end

  def render("usuario.json", %{usuario: usuario}) do
    %{
      id: usuario.id,
      username: usuario.username,
      email: usuario.email,
      password: usuario.password
    }
  end
end

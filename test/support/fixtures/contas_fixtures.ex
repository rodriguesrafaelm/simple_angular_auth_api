defmodule SimpleAuthApi.ContasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SimpleAuthApi.Contas` context.
  """

  @doc """
  Generate a usuario.
  """
  def usuario_fixture(attrs \\ %{}) do
    {:ok, usuario} =
      attrs
      |> Enum.into(%{
        email: "some email",
        password: "some password",
        username: "some username"
      })
      |> SimpleAuthApi.Contas.create_usuario()

    usuario
  end
end

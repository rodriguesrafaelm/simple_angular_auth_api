defmodule SimpleAuthApi.Contas.Usuario do
  use Ecto.Schema
  import Ecto.Changeset

  schema "usuarios" do
    field :email, :string
    field :password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(usuario, attrs) do
    usuario
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
  end
end

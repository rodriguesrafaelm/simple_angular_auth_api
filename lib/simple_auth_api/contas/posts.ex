defmodule SimpleAuthApi.Contas.Post do
  use Ecto.Schema
  import Ecto.Changeset


  schema "posts" do
    field :title, :string
    field :content, :string
    timestamps()
    belongs_to :usuario, SimpleAuthApi.Contas.Usuario

  end

  def changeset(post, attrs) do
  post
  |> cast(attrs, [:usuario_id, :title, :content])
  |> validate_required([:usuario_id, :title, :content])

  end

end

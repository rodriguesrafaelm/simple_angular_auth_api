defmodule SimpleAuthApi.Contas.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:usuario_id, :content, :inserted_at]}
  schema "posts" do
    field :content, :string
    timestamps()
    belongs_to :usuario, SimpleAuthApi.Contas.Usuario

  end

  def changeset(post, attrs) do
  post
  |> cast(attrs, [:usuario_id, :content])
  |> validate_required([:usuario_id, :content])

  end

end

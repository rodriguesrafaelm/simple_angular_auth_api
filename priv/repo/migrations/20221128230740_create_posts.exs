defmodule SimpleAuthApi.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :usuario_id, references("usuarios"), null: false
      add :title, :string, null: false
      add :content, :string, null: false

      timestamps()
    end
  end
end

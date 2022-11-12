defmodule SimpleAuthApi.Repo.Migrations.CreateUsuarios do
  use Ecto.Migration

  def change do
    create table(:usuarios) do
      add :username, :string
      add :email, :string
      add :password, :string

      timestamps()
    end
  end
end

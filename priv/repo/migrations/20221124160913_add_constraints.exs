defmodule SimpleAuthApi.Repo.Migrations.AddConstraints do
  use Ecto.Migration

  def change do
    alter table("usuarios") do
      modify :username, :text, [:unique, null: false]
      modify :email, :text, [:unique, null: false]
      modify :password, :text, [null: false]
    end
    end
end

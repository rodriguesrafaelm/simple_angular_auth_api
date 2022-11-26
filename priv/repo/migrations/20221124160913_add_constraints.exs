defmodule SimpleAuthApi.Repo.Migrations.AddConstraints do
  use Ecto.Migration

  def change do
    alter table("usuarios") do
      modify :username, :text, [null: false]
      modify :email, :text, [null: false]
      modify :password, :text, [null: false]
    end

    create index("usuarios", [:email], unique: true)
    create index("usuarios", [:username], unique: true)

  end
end

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


  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password])
    |> validate_required([:email, :username, :password])
    |> unique_constraint(:email)
    |> encrypt_and_put_password()
  end


  defp encrypt_and_put_password(user) do
    with password <- fetch_field!(user, :password) do
      encrypted_pw = Pbkdf2.hash_pwd_salt(password)
      put_change(user, :password, encrypted_pw)
    end
  end

end

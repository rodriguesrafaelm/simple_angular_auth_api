defmodule SimpleAuthApi.Contas.Usuario do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:email, :username, :posts]}
  schema "usuarios" do
    field :email, :string
    field :password, :string
    field :username, :string
    timestamps()
    has_many :posts, SimpleAuthApi.Contas.Post
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
    |> unique_constraint([:email])
    |> unique_constraint([:username])
    |> validate_length(:password, min: 8, max: 100)
    |> validate_format(:email, ~r/@/)
    |> encrypt_and_put_password()
  end

  defp encrypt_and_put_password(user) do
    case user.valid? do
      true ->
        with password <- fetch_field!(user, :password) do
          encrypted_pw = Pbkdf2.hash_pwd_salt(password)
          put_change(user, :password, encrypted_pw)
        end
      false ->
        user
    end
  end
end

defmodule SimpleAuthApi.Contas do
  @moduledoc """
  The Contas context.
  """

  import Ecto.Query, warn: false
  alias SimpleAuthApi.Repo

  alias SimpleAuthApi.Contas.Usuario





  def add_user(attrs \\ %{}) do
    %Usuario{}
    |> Usuario.registration_changeset(attrs)
    |> Repo.insert()
  end

  def get_user_by_username(username) do
    query = from u in Usuario, where: u.username == ^username
    case Repo.one(query) do
      nil -> {:error, "Usuário não encontrado"}
      user -> {:ok, user}
    end
  end


  def authenticate_user(username, password) do
    case get_user_by_username(username) do
      {:ok, user} ->
      case verify_password(password, user.password) do
        false -> {:error, :unauthorized}
        true -> {:ok, user}
      end
      {:error, message} ->
        {:error, message}
    end
  end

  defp verify_password(password, encrypted_password) do
    Pbkdf2.verify_pass(password, encrypted_password)
  end

  # Default \/



  @doc """
  Returns the list of usuarios.

  ## Examples

      iex> list_usuarios()
      [%Usuario{}, ...]

  """
  def list_usuarios do
    Repo.all(Usuario)
  end

  @doc """
  Gets a single usuario.

  Raises `Ecto.NoResultsError` if the Usuario does not exist.

  ## Examples

      iex> get_usuario!(123)
      %Usuario{}

      iex> get_usuario!(456)
      ** (Ecto.NoResultsError)

  """
  def get_usuario!(id), do: Repo.get!(Usuario, id)

  @doc """
  Creates a usuario.

  ## Examples

      iex> create_usuario(%{field: value})
      {:ok, %Usuario{}}

      iex> create_usuario(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_usuario(attrs \\ %{}) do
    %Usuario{}
    |> Usuario.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a usuario.

  ## Examples

      iex> update_usuario(usuario, %{field: new_value})
      {:ok, %Usuario{}}

      iex> update_usuario(usuario, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_usuario(%Usuario{} = usuario, attrs) do
    usuario
    |> Usuario.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a usuario.

  ## Examples

      iex> delete_usuario(usuario)
      {:ok, %Usuario{}}

      iex> delete_usuario(usuario)
      {:error, %Ecto.Changeset{}}

  """
  def delete_usuario(%Usuario{} = usuario) do
    Repo.delete(usuario)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking usuario changes.

  ## Examples

      iex> change_usuario(usuario)
      %Ecto.Changeset{data: %Usuario{}}

  """
  def change_usuario(%Usuario{} = usuario, attrs \\ %{}) do
    Usuario.changeset(usuario, attrs)
  end





end

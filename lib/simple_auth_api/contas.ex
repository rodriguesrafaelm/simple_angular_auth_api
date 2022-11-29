defmodule SimpleAuthApi.Contas do
  @moduledoc """
  The Contas context.
  """

  import Ecto.Query, warn: false
  alias SimpleAuthApi.Repo

  alias SimpleAuthApi.Contas.Usuario



  def get_user_by_id(id) do
    query = from u in Usuario, where: u.id == ^id
    case Repo.one(query) do
      nil -> {:error, "Usuário não encontrado"}
      user -> {:ok, user}
    end
  end

  def add_user(attrs \\ %{}) do
    %Usuario{}
    |> Usuario.registration_changeset(attrs)
    |> Repo.insert()
  end

  def get_user_by_username(username) do
    query = from u in Usuario, where: u.username == ^username
    IO.inspect(Repo.one(query))
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


  def verify_username_availability(""), do: ""
  def verify_username_availability(username) do
    case get_user_by_username(username) do
      {:error, _message} -> %{message: true}
      {:ok, _user} -> %{message: false}

    end
  end


  def get_user_posts(user_id) do
    user_id = String.to_integer(user_id)
    query = from u in Usuario, preload: [:posts], where: u.id == ^user_id
    Repo.one!(query)
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



end

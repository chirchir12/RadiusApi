defmodule RadiusApi.Devices do
  @moduledoc """
  The Devices context.
  """

  import Ecto.Query, warn: false
  alias RadiusApi.Repo

  alias RadiusApi.Devices.Nas
  alias RadiusApi.Devices.NasReload

  @doc """
  Returns the list of nas.

  ## Examples

      iex> list_nas()
      [%Nas{}, ...]

  """
  def list_nas do
    Repo.all(Nas)
  end

  @doc """
  Gets a single nas.

  Raises `Ecto.NoResultsError` if the Nas does not exist.

  ## Examples

      iex> get_nas!(123)
      %Nas{}

      iex> get_nas!(456)
      ** (Ecto.NoResultsError)

  """
  def get_nas!(id), do: Repo.get!(Nas, id)

  @doc """
  Creates a nas.

  ## Examples

      iex> create_nas(%{field: value})
      {:ok, %Nas{}}

      iex> create_nas(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_nas(attrs \\ %{}) do
    nas = Nas.changeset( %Nas{}, attrs)
    Repo.insert(nas)
  end

  @doc """
  Updates a nas.

  ## Examples

      iex> update_nas(nas, %{field: new_value})
      {:ok, %Nas{}}

      iex> update_nas(nas, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_nas(%Nas{} = nas, attrs) do
    nas
    |> Nas.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a nas.

  ## Examples

      iex> delete_nas(nas)
      {:ok, %Nas{}}

      iex> delete_nas(nas)
      {:error, %Ecto.Changeset{}}

  """
  def delete_nas(%Nas{} = nas) do
    Repo.delete(nas)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking nas changes.

  ## Examples

      iex> change_nas(nas)
      %Ecto.Changeset{data: %Nas{}}

  """
  def change_nas(%Nas{} = nas, attrs \\ %{}) do
    Nas.changeset(nas, attrs)
  end

  def reload_nas(attr \\ %{}) do
    date = DateTime.utc_now()
    attr = Map.put(attr, "reload_time", date)
    changeset = NasReload.changeset(%NasReload{}, attr)
    Repo.insert(changeset)
  end
end

defmodule Chronoquants.Sequences do
  @moduledoc """
  The Sequences context.
  """

  import Ecto.Query, warn: false
  alias Chronoquants.Repo

  alias Chronoquants.Sequences.Sequence
  alias Chronoquants.Users.User

  @doc """
  Returns the list of sequences.

  ## Examples

      iex> list_sequences()
      [%Sequence{}, ...]

  """
  def list_sequences(%User{} = user) do
    Sequence
    |> where(user_id: ^user.id)
    |> Repo.all()
  end

  @doc """
  Gets a single sequence.

  Raises `Ecto.NoResultsError` if the Sequence does not exist.

  ## Examples

      iex> get_sequence!(123)
      %Sequence{}

      iex> get_sequence!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sequence!(id), do: Repo.get!(Sequence, id)

  @doc """
  Creates a sequence.

  ## Examples

      iex> create_sequence(%User{}, %{field: value})
      {:ok, %Sequence{}}

      iex> create_sequence(%User{}, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sequence(%User{} = user, attrs \\ %{}) do
    %Sequence{}
    |> Sequence.changeset(attrs)
    |> Ecto.Changeset.put_change(:user_id, user.id)
    |> Repo.insert()
  end

  @doc """
  Updates a sequence.

  ## Examples

      iex> update_sequence(sequence, %{field: new_value})
      {:ok, %Sequence{}}

      iex> update_sequence(sequence, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sequence(%Sequence{} = sequence, attrs) do
    sequence
    |> Sequence.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sequence.

  ## Examples

      iex> delete_sequence(sequence)
      {:ok, %Sequence{}}

      iex> delete_sequence(sequence)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sequence(%Sequence{} = sequence) do
    Repo.delete(sequence)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sequence changes.

  ## Examples

      iex> change_sequence(sequence)
      %Ecto.Changeset{source: %Sequence{}}

  """
  def change_sequence(%Sequence{} = sequence) do
    Sequence.changeset(sequence, %{})
  end
end

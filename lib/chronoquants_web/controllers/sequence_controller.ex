defmodule ChronoquantsWeb.SequenceController do
  use ChronoquantsWeb, :controller

  alias Chronoquants.Sequences
  alias Chronoquants.Sequences.Sequence

  def index(conn, _params) do
    sequences = Sequences.list_sequences(conn.assigns.current_user)
    render(conn, "index.html", sequences: sequences)
  end

  def new(conn, _params) do
    changeset = Sequences.change_sequence(%Sequence{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sequence" => sequence_params}) do
    case Sequences.create_sequence(conn.assigns.current_user, sequence_params) do
      {:ok, sequence} ->
        conn
        |> put_flash(:info, "Sequence created successfully.")
        |> redirect(to: Routes.sequence_path(conn, :show, sequence))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sequence = Sequences.get_sequence!(id)
    render(conn, "show.html", sequence: sequence)
  end

  def edit(conn, %{"id" => id}) do
    sequence = Sequences.get_sequence!(id)
    changeset = Sequences.change_sequence(sequence)
    render(conn, "edit.html", sequence: sequence, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sequence" => sequence_params}) do
    sequence = Sequences.get_sequence!(id)

    case Sequences.update_sequence(sequence, sequence_params) do
      {:ok, sequence} ->
        conn
        |> put_flash(:info, "Sequence updated successfully.")
        |> redirect(to: Routes.sequence_path(conn, :show, sequence))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sequence: sequence, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sequence = Sequences.get_sequence!(id)
    {:ok, _sequence} = Sequences.delete_sequence(sequence)

    conn
    |> put_flash(:info, "Sequence deleted successfully.")
    |> redirect(to: Routes.sequence_path(conn, :index))
  end
end

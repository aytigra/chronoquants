defmodule Chronoquants.SequencesTest do
  use Chronoquants.DataCase

  alias Chronoquants.Sequences
  import Chronoquants.Factory

  describe "sequences" do
    alias Chronoquants.Sequences.Sequence

    @valid_attrs params_for(:sequence)
    @update_attrs %{name: "some updated name",}
    @invalid_attrs %{name: nil}

    test "list_sequences/1 returns all sequences" do
      sequence = insert(:sequence)
      sequence_id = sequence.id

      assert [%Sequence{id: ^sequence_id}] = Sequences.list_sequences(sequence.user)
    end

    test "get_sequence!/1 returns the sequence with given id" do
      sequence = insert(:sequence)
      sequence_id = sequence.id

      assert %Sequence{id: ^sequence_id} = Sequences.get_sequence!(sequence.id)
    end

    test "create_sequence/1 with valid data creates a sequence" do
      user = insert(:user)
      assert {:ok, %Sequence{} = sequence} = Sequences.create_sequence(user, @valid_attrs)
      assert sequence.name == @valid_attrs.name
    end

    test "create_sequence/1 with invalid data returns error changeset" do
      user = insert(:user)
      assert {:error, %Ecto.Changeset{}} = Sequences.create_sequence(user, @invalid_attrs)
    end

    test "update_sequence/2 with valid data updates the sequence" do
      sequence = insert(:sequence)
      assert {:ok, %Sequence{} = sequence} = Sequences.update_sequence(sequence, @update_attrs)
      assert sequence.name == @update_attrs.name
    end

    test "update_sequence/2 with invalid data returns error changeset" do
      sequence = insert(:sequence)
      not_updated_name = sequence.name
      assert {:error, %Ecto.Changeset{}} = Sequences.update_sequence(sequence, @invalid_attrs)
      assert %Sequence{name: ^not_updated_name} = Sequences.get_sequence!(sequence.id)
    end

    test "delete_sequence/1 deletes the sequence" do
      sequence = insert(:sequence)
      assert {:ok, %Sequence{}} = Sequences.delete_sequence(sequence)
      assert_raise Ecto.NoResultsError, fn -> Sequences.get_sequence!(sequence.id) end
    end

    test "change_sequence/1 returns a sequence changeset" do
      sequence = insert(:sequence)
      assert %Ecto.Changeset{} = Sequences.change_sequence(sequence)
    end
  end
end

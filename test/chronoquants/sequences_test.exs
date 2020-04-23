defmodule Chronoquants.SequencesTest do
  use Chronoquants.DataCase

  alias Chronoquants.Sequences

  describe "sequences" do
    alias Chronoquants.Sequences.Sequence

    @valid_attrs %{name: "some name", public: true, summary: "some summary"}
    @update_attrs %{name: "some updated name", public: false, summary: "some updated summary"}
    @invalid_attrs %{name: nil, public: nil, summary: nil}

    def sequence_fixture(attrs \\ %{}) do
      {:ok, sequence} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sequences.create_sequence()

      sequence
    end

    test "list_sequences/0 returns all sequences" do
      sequence = sequence_fixture()
      assert Sequences.list_sequences() == [sequence]
    end

    test "get_sequence!/1 returns the sequence with given id" do
      sequence = sequence_fixture()
      assert Sequences.get_sequence!(sequence.id) == sequence
    end

    test "create_sequence/1 with valid data creates a sequence" do
      assert {:ok, %Sequence{} = sequence} = Sequences.create_sequence(@valid_attrs)
      assert sequence.name == "some name"
      assert sequence.public == true
      assert sequence.summary == "some summary"
    end

    test "create_sequence/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sequences.create_sequence(@invalid_attrs)
    end

    test "update_sequence/2 with valid data updates the sequence" do
      sequence = sequence_fixture()
      assert {:ok, %Sequence{} = sequence} = Sequences.update_sequence(sequence, @update_attrs)
      assert sequence.name == "some updated name"
      assert sequence.public == false
      assert sequence.summary == "some updated summary"
    end

    test "update_sequence/2 with invalid data returns error changeset" do
      sequence = sequence_fixture()
      assert {:error, %Ecto.Changeset{}} = Sequences.update_sequence(sequence, @invalid_attrs)
      assert sequence == Sequences.get_sequence!(sequence.id)
    end

    test "delete_sequence/1 deletes the sequence" do
      sequence = sequence_fixture()
      assert {:ok, %Sequence{}} = Sequences.delete_sequence(sequence)
      assert_raise Ecto.NoResultsError, fn -> Sequences.get_sequence!(sequence.id) end
    end

    test "change_sequence/1 returns a sequence changeset" do
      sequence = sequence_fixture()
      assert %Ecto.Changeset{} = Sequences.change_sequence(sequence)
    end
  end
end

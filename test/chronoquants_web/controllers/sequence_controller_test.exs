defmodule ChronoquantsWeb.SequenceControllerTest do
  use ChronoquantsWeb.ConnCase

  alias Chronoquants.Sequences

  @create_attrs %{name: "some name", public: true, summary: "some summary"}
  @update_attrs %{name: "some updated name", public: false, summary: "some updated summary"}
  @invalid_attrs %{name: nil, public: nil, summary: nil}

  def fixture(:sequence) do
    {:ok, sequence} = Sequences.create_sequence(@create_attrs)
    sequence
  end

  describe "index" do
    test "lists all sequences", %{conn: conn} do
      conn = get(conn, Routes.sequence_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Sequences"
    end
  end

  describe "new sequence" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.sequence_path(conn, :new))
      assert html_response(conn, 200) =~ "New Sequence"
    end
  end

  describe "create sequence" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.sequence_path(conn, :create), sequence: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.sequence_path(conn, :show, id)

      conn = get(conn, Routes.sequence_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Sequence"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.sequence_path(conn, :create), sequence: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Sequence"
    end
  end

  describe "edit sequence" do
    setup [:create_sequence]

    test "renders form for editing chosen sequence", %{conn: conn, sequence: sequence} do
      conn = get(conn, Routes.sequence_path(conn, :edit, sequence))
      assert html_response(conn, 200) =~ "Edit Sequence"
    end
  end

  describe "update sequence" do
    setup [:create_sequence]

    test "redirects when data is valid", %{conn: conn, sequence: sequence} do
      conn = put(conn, Routes.sequence_path(conn, :update, sequence), sequence: @update_attrs)
      assert redirected_to(conn) == Routes.sequence_path(conn, :show, sequence)

      conn = get(conn, Routes.sequence_path(conn, :show, sequence))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, sequence: sequence} do
      conn = put(conn, Routes.sequence_path(conn, :update, sequence), sequence: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Sequence"
    end
  end

  describe "delete sequence" do
    setup [:create_sequence]

    test "deletes chosen sequence", %{conn: conn, sequence: sequence} do
      conn = delete(conn, Routes.sequence_path(conn, :delete, sequence))
      assert redirected_to(conn) == Routes.sequence_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.sequence_path(conn, :show, sequence))
      end
    end
  end

  defp create_sequence(_) do
    sequence = fixture(:sequence)
    {:ok, sequence: sequence}
  end
end

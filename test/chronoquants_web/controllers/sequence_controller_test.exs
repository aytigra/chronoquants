defmodule ChronoquantsWeb.SequenceControllerTest do
  use ChronoquantsWeb.ConnCase

  alias Chronoquants.Sequences
  import Chronoquants.Factory

  setup %{conn: conn} do
    user = insert(:user)
    conn = Pow.Plug.assign_current_user(conn, user, otp_app: :chronoquants)

    {:ok, conn: conn}
  end

  @create_attrs %{name: "some name", public: true, summary: "some summary"}
  @update_attrs %{name: "some updated name", public: false, summary: "some updated summary"}
  @invalid_attrs %{name: nil, public: nil, summary: nil}

  describe "index" do
    test "lists all sequences", %{conn: conn} do
      sequence = insert(:sequence)
      rconn = get(conn, Routes.sequence_path(conn, :index))
      assert html_response(rconn, 200) =~ "Listing Sequences"
    end
  end

  describe "new sequence" do
    test "renders form", %{conn: conn} do
      rconn = get(conn, Routes.sequence_path(conn, :new))
      assert html_response(rconn, 200) =~ "New Sequence"
    end
  end

  describe "create sequence" do
    test "redirects to show when data is valid", %{conn: conn} do
      rconn = post(conn, Routes.sequence_path(conn, :create), sequence: @create_attrs)

      assert %{id: id} = redirected_params(rconn)
      assert redirected_to(rconn) == Routes.sequence_path(conn, :show, id)

      rconn = get(conn, Routes.sequence_path(conn, :show, id))
      assert html_response(rconn, 200) =~ "Show Sequence"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      rconn = post(conn, Routes.sequence_path(conn, :create), sequence: @invalid_attrs)
      assert html_response(rconn, 200) =~ "New Sequence"
    end
  end

  describe "edit sequence" do
    test "renders form for editing chosen sequence", %{conn: conn} do
      sequence = insert(:sequence)
      rconn = get(conn, Routes.sequence_path(conn, :edit, sequence))
      assert html_response(rconn, 200) =~ "Edit Sequence"
    end
  end

  describe "update sequence" do
    test "redirects when data is valid", %{conn: conn} do
      sequence = insert(:sequence)
      rconn = put(conn, Routes.sequence_path(conn, :update, sequence), sequence: @update_attrs)
      assert redirected_to(rconn) == Routes.sequence_path(conn, :show, sequence)

      rconn = get(conn, Routes.sequence_path(conn, :show, sequence))
      assert html_response(rconn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      sequence = insert(:sequence)
      rconn = put(conn, Routes.sequence_path(conn, :update, sequence), sequence: @invalid_attrs)
      assert html_response(rconn, 200) =~ "Edit Sequence"
    end
  end

  describe "delete sequence" do
    test "deletes chosen sequence", %{conn: conn} do
      sequence = insert(:sequence)
      rconn = delete(conn, Routes.sequence_path(conn, :delete, sequence))
      assert redirected_to(rconn) == Routes.sequence_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.sequence_path(conn, :show, sequence))
      end
    end
  end
end

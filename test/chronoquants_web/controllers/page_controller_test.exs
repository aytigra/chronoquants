defmodule ChronoquantsWeb.PageControllerTest do
  use ChronoquantsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Chronoquants"
  end
end

defmodule ChronoquantsWeb.PageControllerTest do
  use ChronoquantsWeb.ConnCase

  alias Chronoquants.Users.User

  setup %{conn: conn} do
    user = %User{email: "test@example.com", name: "Tester"}
    conn = Pow.Plug.assign_current_user(conn, user, otp_app: :chronoquants)

    {:ok, conn: conn}
  end

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Chronoquants"
  end
end

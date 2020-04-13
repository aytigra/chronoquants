defmodule ChronoquantsWeb.PageController do
  use ChronoquantsWeb, :controller

  #alias Chronoquants.{Mailer}
  #alias ChronoquantsWeb.{UserEmail}

  def index(conn, _params) do
    # %{name: "Tony Stark", email: "tony.stark@example.com"}
    # |> UserEmail.welcome()
    # |> Mailer.deliver

    render(conn, "index.html")
  end
end

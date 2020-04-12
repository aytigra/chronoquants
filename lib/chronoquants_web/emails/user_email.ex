defmodule ChronoquantsWeb.UserEmail do
  use Phoenix.Swoosh, view: ChronoquantsWeb.Email.UserView, layout: {ChronoquantsWeb.LayoutView, :email}

  def welcome(user) do
    new()
    |> from("noreply@chronoquants.com")
    |> to({user.name, user.email})
    |> subject("Hello, Avengers!")
    |> render_body("welcome.html", %{username: user.name})
  end
end
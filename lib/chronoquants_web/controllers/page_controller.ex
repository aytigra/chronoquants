defmodule ChronoquantsWeb.PageController do
  use ChronoquantsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

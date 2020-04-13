defmodule ChronoquantsWeb.Router do
  use ChronoquantsWeb, :router
  use Pow.Phoenix.Router
  use Pow.Extension.Phoenix.Router,
    extensions: [PowResetPassword, PowEmailConfirmation, PowPersistentSession]
  use PowAssent.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :skip_csrf_protection do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :authenticated do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :skip_csrf_protection

    pow_assent_authorization_post_callback_routes()
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
    pow_assent_routes()
  end

  scope "/", ChronoquantsWeb do
    pipe_through [:browser, :authenticated]

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChronoquantsWeb do
  #   pipe_through :api
  # end

  if Mix.env == :dev do
    scope "/dev" do
      pipe_through [:browser]

      forward "/mailbox", Plug.Swoosh.MailboxPreview, [base_path: "/dev/mailbox"]
    end
  end
end

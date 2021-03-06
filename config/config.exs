# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :chronoquants,
  ecto_repos: [Chronoquants.Repo]

# Configures the endpoint
config :chronoquants, ChronoquantsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "h4f3R0vRIObI8QtgGFAoEsfGgIT6iZUoVCkQHSgHgTRpKRMrGCieinxq6vI9OhK/",
  render_errors: [view: ChronoquantsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Chronoquants.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "kl9InIEw"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :chronoquants, :pow,
  user: Chronoquants.Users.User,
  repo: Chronoquants.Repo,
  web_module: ChronoquantsWeb,
  extensions: [PowResetPassword, PowEmailConfirmation, PowPersistentSession],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  mailer_backend: ChronoquantsWeb.Pow.Mailer,
  web_mailer_module: ChronoquantsWeb

config :chronoquants, :pow_assent,
  providers: [
    github: [
      client_id: "1ec4907d88517b303f15",
      client_secret: "77185e010d63855efc76acf4286eec63ede3acf1",
      strategy: Assent.Strategy.Github
    ]
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

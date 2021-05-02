# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :toggle_example,
  ecto_repos: [ToggleExample.Repo]

# Configures the endpoint
config :toggle_example, ToggleExampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QqRrsBsiAdvcZHYl0vFLbsU6Zr7X1ZO0sP4L7dqcj/1sVRcFt5vyti5B9zv3v7Go",
  render_errors: [view: ToggleExampleWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ToggleExample.PubSub,
  live_view: [signing_salt: "I6jSv3Za"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

to_boolean = fn
  "true", _ -> true
  "false", _ -> false
  _, default -> default
end

config :toggle_example, :toggles,
  env_var_toggle_1: to_boolean.(System.get_env("ENV_TOGGLE_1"), false)

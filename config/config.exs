# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :liveview_diff_issue,
  ecto_repos: [LiveviewDiffIssue.Repo]

# Configures the endpoint
config :liveview_diff_issue, LiveviewDiffIssueWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FH5cVU1l14/+oLJYziI3Hpyj3zQ7UADVzLvud+cEBHA3RAzKSMv5l/PPirsF2xdB",
  render_errors: [view: LiveviewDiffIssueWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: LiveviewDiffIssue.PubSub,
  live_view: [signing_salt: "wjod6S+x"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine,
  slimleex: PhoenixSlime.LiveViewEngine

config :phoenix_slime, :use_slim_extension, true

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

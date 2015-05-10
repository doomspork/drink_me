use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :drink_me, DrinkMe.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :drink_me, DrinkMe.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "drink_me_test",
  size: 1,
  max_overflow: 0

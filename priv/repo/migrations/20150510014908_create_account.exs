defmodule DrinkMe.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\""

    create table(:accounts) do
      add :api_key, :uuid, null: false, default: fragment("uuid_generate_v4()")
      add :aws_access_id, :text, null: false
      add :aws_secret_key, :text, null: false
      add :email, :text, null: false

      timestamps
    end
  end
end

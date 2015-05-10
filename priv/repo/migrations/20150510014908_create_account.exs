defmodule DrinkMe.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :name, :string
      add :aws_secret_key, :string
      add :aws_access_id, :string

      timestamps
    end
  end
end

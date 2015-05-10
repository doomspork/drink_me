defmodule DrinkMe.Account do
  use DrinkMe.Web, :model

  schema "accounts" do
    field :api_key, Ecto.UUID, read_after_writes: true
    field :aws_access_id, :string
    field :aws_secret_key, :string
    field :email, :string

    timestamps
  end

  before_insert :generate_api_key

  @required_fields ~w(aws_access_id aws_secret_key email)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ nil) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def generate_api_key(changeset) do
    changeset |> put_change(:api_key, Ecto.UUID.generate)
  end

end

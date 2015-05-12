defmodule DrinkMe.Account do
  use DrinkMe.Web, :model

  @primary_key {:id, :uuid, read_after_writes: true}

  schema "accounts" do
    field :aws_access_id, :string
    field :aws_secret_key, :string
    field :email, :string

    timestamps
  end

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
end

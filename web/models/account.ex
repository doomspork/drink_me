defmodule DrinkMe.Account do
  use DrinkMe.Web, :model

  schema "accounts" do
    field :name, :string
    field :aws_secret_key, :string
    field :aws_access_id, :string

    timestamps
  end

  @required_fields ~w(name aws_secret_key aws_access_id)
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

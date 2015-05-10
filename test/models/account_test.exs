defmodule DrinkMe.AccountTest do
  use DrinkMe.ModelCase

  alias DrinkMe.Account

  @valid_attrs %{aws_access_id: "some content", aws_secret_key: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Account.changeset(%Account{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Account.changeset(%Account{}, @invalid_attrs)
    refute changeset.valid?
  end
end

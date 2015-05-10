defmodule DrinkMe.AccountView do
  use DrinkMe.Web, :view

  def render("index.json", %{accounts: accounts}) do
    %{account: render_many(accounts, "account.json")}
  end

  def render("show.json", %{account: account}) do
    %{account: render_one(account, "account.json")}
  end

  def render("account.json", %{account: account}) do
    %{id: account.id, name: account.name, access_id: account.aws_access_id}
  end
end

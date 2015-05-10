defmodule DrinkMe.AccountController do
  use DrinkMe.Web, :controller

  alias DrinkMe.Account

  plug :scrub_params, "account" when action in [:create, :update]
  plug :action

  def index(conn, _) do
    accounts = Repo.all(Account)
    render(conn, "index.json", accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    changeset = Account.changeset(%Account{}, account_params)

    if changeset.valid? do
      account = Repo.insert(changeset)
      render(conn, "show.json", account: account)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(DrinkMe.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    account = Repo.get(Account, id)
    render conn, "show.json", account: account
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Repo.get(Account, id)
    changeset = Account.changeset(account, account_params)

    if changeset.valid? do
      account = Repo.update(changeset)
      render(conn, "show.json", account: account)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(DrinkMe.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Repo.get(Account, id)

    account = Repo.delete(account)
    render(conn, "show.json", account: account)
  end
end

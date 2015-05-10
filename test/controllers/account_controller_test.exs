defmodule DrinkMe.AccountControllerTest do
  use DrinkMe.ConnCase

  alias DrinkMe.Account
  @valid_params account: %{aws_access_id: "new key", aws_secret_key: "new secret", email: "test@example.com"}
  @invalid_params account: %{}
  @minimal_account %Account{aws_access_id: "old key", aws_secret_key: "old secret", email: "test@example.com" }

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "GET /accounts", %{conn: conn} do
    conn = get conn, account_path(conn, :index)
    assert json_response(conn, 200)["account"] == []
  end

  test "GET /accounts/:id", %{conn: conn} do
    account = Repo.insert @minimal_account
    conn = get conn, account_path(conn, :show, account)
    assert json_response(conn, 200)["account"] == %{
      "access_id" => account.aws_access_id,
      "api_key" => account.api_key,
      "email" => account.email,
      "id" => account.id
    }
  end

  test "POST /accounts with valid data", %{conn: conn} do
    conn = post conn, account_path(conn, :create), @valid_params
    assert json_response(conn, 200)["account"]["id"]
    assert json_response(conn, 200)["account"]["api_key"]
  end

  test "POST /accounts with invalid data", %{conn: conn} do
    conn = post conn, account_path(conn, :create), @invalid_params
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "PUT /accounts/:id with valid data", %{conn: conn} do
    account = Repo.insert @minimal_account
    conn = put conn, account_path(conn, :update, account), @valid_params
    assert json_response(conn, 200)["account"]["id"]
    assert json_response(conn, 200)["account"]["access_id"] == "new key"
  end

  test "DELETE /accounts/:id", %{conn: conn} do
    account = Repo.insert @minimal_account
    conn = delete conn, account_path(conn, :delete, account)
    assert json_response(conn, 200)["account"]["id"]
    refute Repo.get(Account, account.id)
  end
end

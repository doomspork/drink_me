defmodule DrinkMe.AccountControllerTest do
  use DrinkMe.ConnCase

  alias DrinkMe.Account
  @valid_params account: %{aws_access_id: "some content", aws_secret_key: "some content", name: "some content"}
  @invalid_params account: %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "GET /accounts", %{conn: conn} do
    conn = get conn, account_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "GET /accounts/:id", %{conn: conn} do
    account = Repo.insert %Account{}
    conn = get conn, account_path(conn, :show, account)
    assert json_response(conn, 200)["data"] == %{
      "id" => account.id
    }
  end

  test "POST /accounts with valid data", %{conn: conn} do
    conn = post conn, account_path(conn, :create), @valid_params
    assert json_response(conn, 200)["data"]["id"]
  end

  test "POST /accounts with invalid data", %{conn: conn} do
    conn = post conn, account_path(conn, :create), @invalid_params
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "PUT /accounts/:id with valid data", %{conn: conn} do
    account = Repo.insert %Account{}
    conn = put conn, account_path(conn, :update, account), @valid_params
    assert json_response(conn, 200)["data"]["id"]
  end

  test "PUT /accounts/:id with invalid data", %{conn: conn} do
    account = Repo.insert %Account{}
    conn = put conn, account_path(conn, :update, account), @invalid_params
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "DELETE /accounts/:id", %{conn: conn} do
    account = Repo.insert %Account{}
    conn = delete conn, account_path(conn, :delete, account)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Account, account.id)
  end
end

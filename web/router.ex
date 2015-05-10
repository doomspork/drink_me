defmodule DrinkMe.Router do
  use DrinkMe.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DrinkMe do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", DrinkMe do
    pipe_through :api

    resources "accounts", AccountController
  end

end

defmodule DrinkMe.PageController do
  use DrinkMe.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end

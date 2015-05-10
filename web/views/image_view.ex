defmodule DrinkMe.ImageView do
  use DrinkMe.Web, :view

  def render("show.json", %{path: path}) do
    %{image: render("image.json", path)}
  end

  def render("image.json", path) do
    %{path: path}
  end

  def render("error.json", %{}) do
    %{}
  end
end

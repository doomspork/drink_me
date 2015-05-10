defmodule DrinkMe.ImageController do
  use DrinkMe.Web, :controller

  require HTTPotion

  plug :scrub_params, "image" when action in [:create]
  plug :action

  def create(conn, %{"image" => image_params}) do
    case download(image_params["path"]) do
      { :ok, path } ->
        spawn fn -> modify(path) end
        render(conn, "show.json", path: path)
      _ ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json")
    end
  end

  defp modify(path) do
    path |> Mogrify.open |> Mogrify.resize("500x500")
  end

  defp download(path) do
    response = HTTPotion.get path
    tmpfile response.body |> to_string
  end

  defp tmpfile(data) do
    path = tmp_path
    {:ok, file} = File.open path, [:write]
    :ok = IO.binwrite file, data
    File.close(file)
    {:ok, path}
  end

  defp tmp_path() do
    System.tmp_dir <> random_str
  end

  defp random_str() do
    Enum.map_join 1..30, fn(_) ->
      "abcdefghijklmnopqrstuvwxyz0123456789" |> String.at :random.uniform(36) - 1
    end
  end
end

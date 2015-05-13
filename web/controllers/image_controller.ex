defmodule DrinkMe.ImageController do
  use DrinkMe.Web, :controller
  require HTTPotion

  import DrinkMe.Files
  import DrinkMe.Images

  plug :scrub_params, "image" when action in [:create]
  plug :action

  def create(conn, %{"image" => image_params}) do
    case download(image_params["path"]) do
      {:ok, path} ->
        Task.start fn -> process(path, image_params, conn.assigns[:account]) end
        conn
        |> put_status(:accepted)
        |> render("show.json", path: path)
      _ ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json")
    end
  end

  defp download(path) do
    path
    |> HTTPotion.get
    |> response_body
    |> to_string
    |> tmpfile path
  end

  defp response_body(resp) do
    resp.body
  end

  defp process(path, params, account) do
    path
    |> mogrify(%{"format": "PNG"} |> Map.merge params["changes"])
    |> shrink
    |> upload account
  end

  defp upload(path, account) do
    name = path
           |> extract_filename
    IO.puts("Uploading file " <> name)
  end

end

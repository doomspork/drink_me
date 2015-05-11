defmodule DrinkMe.ImageController do
  use DrinkMe.Web, :controller
  require HTTPotion

  plug :scrub_params, "image" when action in [:create]
  plug :action

  def create(conn, %{"image" => image_params}) do
    case download(image_params["path"]) do
      { :ok, path } ->
        Task.start fn -> 
          modify(path, image_params["changes"]) 
        end
        render(conn, "show.json", path: path)
      _ ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json")
    end
  end

  defp modify(path, changes) do
    args = mogrify_args path, changes
    System.cmd "mogrify", args, stderr_to_stdout: true
  end

  defp mogrify_args(path, changes) do
    args = Enum.map_join changes, " ", fn {k, v} -> ~s(-#{k} #{v}) end
    ~w(#{args} #{String.replace(path, " ", "\\ ")})
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

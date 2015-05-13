defmodule DrinkMe.Files do
  def tmpfile(data, path) do
    {:ok, file} = path
                  |> extract_filename
                  |> tmp_path
                  |> File.open [:write]
    :ok = IO.binwrite file, data
    File.close(file)
    {:ok, path}
  end
  
  def extract_filename(path) do
    ext = path |> Path.extname
    path
    |> Path.basename(ext)
    |> match_name
  end

  defp tmp_path(path) do
    Path.join System.tmp_dir, (path <> "--" <> random_str)
  end

  defp match_name(path) do
    [_| tail] = Regex.run(~r/(.*)(-[-|shrunk])?/, path)
    tail |> List.first
  end

  defp random_str() do
    Enum.map_join 1..5, fn(_) ->
      "abcdefghijklmnopqrstuvwxyz0123456789" |> String.at :random.uniform(36) - 1
    end
  end
end

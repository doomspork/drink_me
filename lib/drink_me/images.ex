defmodule DrinkMe.Images do
  def mogrify(path, changes) do
    System.cmd "mogrify", mogrify_args(path, changes), stderr_to_stdout: true
    path
  end

  def shrink(path) do
    args = ~w(--quality=60-80 --ext=-shrunk.png -- #{path})
    System.cmd "pngquant", args, stderr_to_stdout: true
    shrunk_path = path <> "-shrunk.png"
    case File.exists?(shrunk_path) do
      true  -> shrunk_path
      false -> path
    end
  end

  defp mogrify_args(path, changes) do
    args = Enum.map_join changes, " ", fn {k, v} -> ~s(-#{k} #{v}) end
    ~w(#{args} #{String.replace(path, " ", "\\ ")})
  end
end

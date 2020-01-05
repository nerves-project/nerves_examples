defmodule Gengraph.FirmwareSizes do
  @spec load(Path.t()) :: list()
  def load(path) do
    raw_data = load_raw_data(path)

    sha_map = sha_order(raw_data)

    annotate_sha_order(raw_data, sha_map)
  end

  defp sha_order(data) do
    {result, _index} =
      Enum.reduce(data, {%{}, 0}, fn row, {sha_map, index} ->
        if Map.has_key?(sha_map, row.sha) do
          {sha_map, index}
        else
          {Map.put(sha_map, row.sha, index), index + 1}
        end
      end)

    result
  end

  defp annotate_sha_order(data, sha_map) do
    Enum.map(data, fn row -> Map.put(row, :sha_order, Map.get(sha_map, row.sha)) end)
  end

  defp load_raw_data(path) do
    File.stream!(path)
    |> CSV.decode(validate_row_length: false)
    |> Stream.drop(1)
    |> Enum.map(&process_row/1)
  end

  # Handle rows before mix_env was saved
  defp process_row({:ok, [build, timestamp, branch, sha1, project, target, firmware_size]}) do
    process_row({:ok, [build, timestamp, branch, sha1, project, target, "dev", firmware_size]})
  end

  defp process_row(
         {:ok, [build, timestamp, branch, sha1, project, target, mix_env, firmware_size]}
       ) do
    %{
      build: parse_int(build),
      timestamp: DateTime.from_unix!(parse_int(timestamp)),
      branch: branch,
      sha: sha1,
      project: project,
      target: target,
      mix_env: mix_env,
      firmware_size: parse_int(firmware_size)
    }
  end

  defp parse_int(str) do
    {int, ""} = Integer.parse(str)
    int
  end
end

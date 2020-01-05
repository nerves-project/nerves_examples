defmodule Gengraph do
  def main(_) do
    all_firmware_sizes = Gengraph.FirmwareSizes.load("../firmware_size.csv")

    for project <- projects() do
      plot_firmware_sizes(all_firmware_sizes, project)
    end
  end

  defp projects() do
    [
      "blinky",
      "hello_gpio",
      "hello_erlang",
      "hello_lfe",
      "hello_leds",
      "hello_phoenix/firmware",
      "minimal"
    ]
  end

  defp targets() do
    ["rpi", "rpi0", "rpi2", "rpi3", "rpi3a", "rpi4", "bbb", "x86_64"]
  end

  defp mix_envs() do
    ["dev", "prod"]
  end

  defp plot_firmware_sizes(all_firmware_sizes, project) do
    plot_specs =
      for target <- targets(), mix_env <- mix_envs(), do: plot_spec(target <> "/" <> mix_env)

    data =
      for target <- targets(),
          mix_env <- mix_envs(),
          do: firmware_size_by_sha(all_firmware_sizes, project, target, mix_env)

    Gnuplot.plot(
      [
        [:set, :term, :png, :size, '1024,768'],
        [:set, :output, output_filename(project)],
        [:set, :title, escape_name(project)],
        [:set, :format, :y, "%.0s%cB"],
        [
          :set,
          'xtics border in scale 1,0.5 nomirror rotate by -45 offset character 0, 0, 0     norangelimit'
        ],
        Gnuplot.plots(plot_specs)
      ],
      data
    )
  end

  defp output_filename(project) do
    "firmware_sizes-#{safe_filename(project)}.png"
  end

  defp safe_filename(name) do
    for <<c <- name>>, into: "" do
      case c do
        ?/ -> "_"
        _ -> <<c>>
      end
    end
  end

  defp escape_name(name) do
    for <<c <- name>>, into: "" do
      case c do
        ?_ -> "\\\\_"
        _ -> <<c>>
      end
    end
  end

  defp plot_spec(title) do
    ["-", :using, '1:2:xtic(3)', :title, escape_name(title), :with, :linespoints]
  end

  def firmware_size_by_sha(all_firmware_sizes, project, target, mix_env) do
    all_firmware_sizes
    |> Enum.filter(fn row ->
      row.project == project and row.target == target and row.mix_env == mix_env
    end)
    |> Enum.map(fn row -> [row.sha_order, row.firmware_size, pretty_date_sha(row)] end)
  end

  def pretty_date_sha(row) do
    ts = row.timestamp
    "\"#{ts.year}-#{ts.month}-#{ts.day}-#{String.slice(row.sha, 0, 7)}\""
  end
end

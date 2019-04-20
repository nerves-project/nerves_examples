defmodule Mix.Tasks.Compile.Lfe do
  use Mix.Task.Compiler
  import Mix.Compilers.Lfe

  @recursive true
  @manifest "compile.lfe"
  @switches [force: :boolean, all_warnings: :boolean]

  @moduledoc """
  Compiles LFE source files.

  Uses an [idea](https://github.com/elixir-lang/elixir/blob/e1c903a5956e4cb9075f0aac00638145788b0da4/lib/mix/lib/mix/compilers/erlang.ex#L20) from the Erlang Mix compiler to do so.

  These options are supported:

  ## Command line options
    * `--force` - forces compilation regardless of modification times
    * `--all-warnings` - prints warnings even from files that do not need to be recompiled

  ## Configuration

  The [Erlang compiler configuration](https://github.com/elixir-lang/elixir/blob/master/lib/mix/lib/mix/tasks/compile.erlang.ex#L31) is supported.
  Specific configuration options for the LFE compiler will be supported in future.
  """

  @doc """
  Runs this task.
  """
  def run(args) do
    {opts, _, _} = OptionParser.parse(args, switches: @switches)
    do_run(opts)
  end

  defp do_run(opts) do
    dest = Mix.Project.compile_path()

    compile(manifest(), [{"src", dest}], opts)
  end

  @doc """
  Returns LFE manifests.
  """
  def manifests, do: [manifest()]

  @doc """
  Cleans up compilation artifacts.
  """
  def clean, do: clean(manifest())

  defp manifest, do: Path.join(Mix.Project.manifest_path(), @manifest)
end

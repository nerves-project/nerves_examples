defmodule Mix.Compilers.Lfe do
  alias Mix.Compilers.Erlang, as: ErlangCompiler

  @moduledoc false

  @doc """
  Compiles the files in `mappings` with '.lfe' extensions into
  the destinations.
  Does this for each stale input and output pair (or for all if `force` is `true`) and
  removes files that no longer have a source, while keeping the `manifest` up to date.

  `mappings` should be a list of tuples in the form of `{src, dest}` paths.

  Uses an [idea](https://github.com/elixir-lang/elixir/blob/e1c903a5956e4cb9075f0aac00638145788b0da4/lib/mix/lib/mix/compilers/erlang.ex#L20) from the Erlang Mix compiler to do so.

  It supports the options of the Erlang Mix compiler under the covers as it is used.
  """
  def compile(manifest, [{_, _} | _] = mappings, opts) do
    callback = fn input, output ->
      module = input |> Path.basename(".lfe") |> String.to_atom()
      :code.purge(module)
      :code.delete(module)

      outdir = output |> Path.dirname() |> ErlangCompiler.to_erl_file()

      compile_result(
        :lfe_comp.file(ErlangCompiler.to_erl_file(input), [{:outdir, outdir}, :return, :report])
      )
    end

    ErlangCompiler.compile(manifest, mappings, :lfe, :beam, opts, callback)
  end

  @doc """
  Removes compiled files for the given `manifest`.
  """
  def clean(manifest), do: ErlangCompiler.clean(manifest)

  defp compile_result({:error, [{:error, [{file, [error | _]}], []}], [], []}) do
    {:error, [{file, [error]}], []}
  end

  defp compile_result(result), do: result
end

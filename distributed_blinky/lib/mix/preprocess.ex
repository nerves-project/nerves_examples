defmodule Mix.Tasks.Preprocess do
  use Mix.Task

  def run(_) do
    file = EEx.eval_file "priv/vm.args.eex"

    Mix.Generator.create_file "rel/vm.args", file, [force: true]
  end

end

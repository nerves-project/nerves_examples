defmodule HelloSnmpAgent do
  @moduledoc """
  Documentation for HelloSnmpAgent.
  """

  @doc """
  Hello world.

  ## Examples

      iex> HelloSnmpAgent.hello
      :world

  """
  def hello do
    :world
  end

  @doc """
  Added this here for demonstration purposes, easy way to move required SNMP
  conf files to needed place. Naturally you'd want to make sure the destination
  stays in sync with what you have in config/target.exs, probably find a better
  place for this, etc.

  """
  def copy_conf() do
    priv_dir = "lib/hello_snmp_agent-0.1.0/priv/"
    {:ok, files} = File.ls(priv_dir)

    for file <- files, Path.extname(file) == ".conf",
      do: File.cp!(priv_dir <> "/#{file}", "/root/#{file}")
  end
end

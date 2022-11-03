defmodule Firmware do
  @moduledoc """
  Documentation for Firmware.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Firmware.hello
      :world

  """
  def hello do
    :world
  end

  defdelegate hello_ui, to: Ui, as: :hello
  defdelegate list_users, to: Ui.Accounts
end

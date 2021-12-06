defmodule Ui.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ui.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        age: 42,
        name: "some name"
      })
      |> Ui.Accounts.create_user()

    user
  end
end

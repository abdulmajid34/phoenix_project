defmodule PhoenixFramework.WorldsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixFramework.Worlds` context.
  """

  @doc """
  Generate a space.
  """
  def space_fixture(attrs \\ %{}) do
    {:ok, space} =
      attrs
      |> Enum.into(%{
        id: PhoenixFramework.Utils.random_string(5),
        description: "some description",
        name: "some name"
      })
      |> PhoenixFramework.Worlds.create_space()

    space
  end
end

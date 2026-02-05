defmodule PPhoenixLiveviewCourse.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PPhoenixLiveviewCourse.Catalog` context.
  """

  @doc """
  Generate a unique game sku.
  """
  def unique_game_sku, do: System.unique_integer([:positive])

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        sku: unique_game_sku(),
        unit_price: 120.5
      })
      |> PPhoenixLiveviewCourse.Catalog.create_game()

    game
  end
end

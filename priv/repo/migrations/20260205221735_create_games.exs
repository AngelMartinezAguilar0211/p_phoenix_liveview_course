defmodule PPhoenixLiveviewCourse.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string
      add :description, :string
      add :unit_price, :float
      add :sku, :integer

      timestamps(type: :utc_datetime)
    end

    create unique_index(:games, [:sku])
  end
end

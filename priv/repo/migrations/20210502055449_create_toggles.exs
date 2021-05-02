defmodule ToggleExample.Repo.Migrations.CreateToggles do
  use Ecto.Migration

  def change do
    create table(:toggles) do
      add :name, :string
      add :value, :boolean, default: false, null: false

      timestamps()
    end
  end
end

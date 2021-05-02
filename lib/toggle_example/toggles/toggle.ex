defmodule ToggleExample.Toggles.Toggle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "toggles" do
    field :name, :string
    field :value, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(toggle, attrs) do
    toggle
    |> cast(attrs, [:name, :value])
    |> validate_required([:name, :value])
  end
end

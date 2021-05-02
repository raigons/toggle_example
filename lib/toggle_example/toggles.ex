defmodule ToggleExample.Toggles do
  @moduledoc """
  The Toggles context.
  """

  import Ecto.Query, warn: false
  alias ToggleExample.Repo

  alias ToggleExample.Toggles.Toggle

  @doc """
  Returns the list of toggles.

  ## Examples

      iex> list_toggles()
      [%Toggle{}, ...]

  """
  def list_toggles do
    Repo.all(Toggle)
  end

  def get_toggle_by_name(name) do
    Repo.get_by(Toggle, name: name)
  end

  @doc """
  Creates a toggle.

  ## Examples

      iex> create_toggle(%{field: value})
      {:ok, %Toggle{}}

      iex> create_toggle(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_toggle(attrs \\ %{}) do
    %Toggle{}
    |> Toggle.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a toggle.

  ## Examples

      iex> update_toggle(toggle, %{field: new_value})
      {:ok, %Toggle{}}

      iex> update_toggle(toggle, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_toggle(%Toggle{} = toggle, attrs) do
    toggle
    |> Toggle.changeset(attrs)
    |> Repo.update()
  end
end

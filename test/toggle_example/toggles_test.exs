defmodule ToggleExample.TogglesTest do
  use ToggleExample.DataCase

  alias ToggleExample.Toggles

  describe "toggles" do
    alias ToggleExample.Toggles.Toggle

    @valid_attrs %{name: "some name", value: true}
    @update_attrs %{name: "some updated name", value: false}
    @invalid_attrs %{name: nil, value: nil}

    def toggle_fixture(attrs \\ %{}) do
      {:ok, toggle} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Toggles.create_toggle()

      toggle
    end

    test "list_toggles/0 returns all toggles" do
      toggle = toggle_fixture()
      assert Toggles.list_toggles() == [toggle]
    end

    test "get_toggle!/1 returns the toggle with given id" do
      toggle = toggle_fixture()
      assert Toggles.get_toggle!(toggle.id) == toggle
    end

    test "create_toggle/1 with valid data creates a toggle" do
      assert {:ok, %Toggle{} = toggle} = Toggles.create_toggle(@valid_attrs)
      assert toggle.name == "some name"
      assert toggle.value == true
    end

    test "create_toggle/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Toggles.create_toggle(@invalid_attrs)
    end

    test "update_toggle/2 with valid data updates the toggle" do
      toggle = toggle_fixture()
      assert {:ok, %Toggle{} = toggle} = Toggles.update_toggle(toggle, @update_attrs)
      assert toggle.name == "some updated name"
      assert toggle.value == false
    end

    test "update_toggle/2 with invalid data returns error changeset" do
      toggle = toggle_fixture()
      assert {:error, %Ecto.Changeset{}} = Toggles.update_toggle(toggle, @invalid_attrs)
      assert toggle == Toggles.get_toggle!(toggle.id)
    end

    test "delete_toggle/1 deletes the toggle" do
      toggle = toggle_fixture()
      assert {:ok, %Toggle{}} = Toggles.delete_toggle(toggle)
      assert_raise Ecto.NoResultsError, fn -> Toggles.get_toggle!(toggle.id) end
    end

    test "change_toggle/1 returns a toggle changeset" do
      toggle = toggle_fixture()
      assert %Ecto.Changeset{} = Toggles.change_toggle(toggle)
    end
  end
end

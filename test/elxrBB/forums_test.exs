defmodule ElxrBB.ForumsTest do
  use ElxrBB.DataCase

  alias ElxrBB.Forums

  describe "forums" do
    alias ElxrBB.Forums.Forum

    import ElxrBB.ForumsFixtures

    @invalid_attrs %{description: nil, title: nil}

    test "list_forums/0 returns all forums" do
      forum = forum_fixture()
      assert Forums.list_forums() == [forum]
    end

    test "get_forum!/1 returns the forum with given id" do
      forum = forum_fixture()
      assert Forums.get_forum!(forum.id) == forum
    end

    test "create_forum/1 with valid data creates a forum" do
      valid_attrs = %{description: "some description", title: "some title"}

      assert {:ok, %Forum{} = forum} = Forums.create_forum(valid_attrs)
      assert forum.description == "some description"
      assert forum.title == "some title"
    end

    test "create_forum/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forums.create_forum(@invalid_attrs)
    end

    test "update_forum/2 with valid data updates the forum" do
      forum = forum_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title"}

      assert {:ok, %Forum{} = forum} = Forums.update_forum(forum, update_attrs)
      assert forum.description == "some updated description"
      assert forum.title == "some updated title"
    end

    test "update_forum/2 with invalid data returns error changeset" do
      forum = forum_fixture()
      assert {:error, %Ecto.Changeset{}} = Forums.update_forum(forum, @invalid_attrs)
      assert forum == Forums.get_forum!(forum.id)
    end

    test "delete_forum/1 deletes the forum" do
      forum = forum_fixture()
      assert {:ok, %Forum{}} = Forums.delete_forum(forum)
      assert_raise Ecto.NoResultsError, fn -> Forums.get_forum!(forum.id) end
    end

    test "change_forum/1 returns a forum changeset" do
      forum = forum_fixture()
      assert %Ecto.Changeset{} = Forums.change_forum(forum)
    end
  end
end

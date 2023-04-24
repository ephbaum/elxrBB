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

  describe "topics" do
    alias ElxrBB.Forums.Topic

    import ElxrBB.ForumsFixtures

    @invalid_attrs %{body: nil, title: nil}

    test "list_topics/0 returns all topics" do
      topic = topic_fixture()
      assert Forums.list_topics() == [topic]
    end

    test "get_topic!/1 returns the topic with given id" do
      topic = topic_fixture()
      assert Forums.get_topic!(topic.id) == topic
    end

    test "create_topic/1 with valid data creates a topic" do
      valid_attrs = %{body: "some body", title: "some title"}

      assert {:ok, %Topic{} = topic} = Forums.create_topic(valid_attrs)
      assert topic.body == "some body"
      assert topic.title == "some title"
    end

    test "create_topic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forums.create_topic(@invalid_attrs)
    end

    test "update_topic/2 with valid data updates the topic" do
      topic = topic_fixture()
      update_attrs = %{body: "some updated body", title: "some updated title"}

      assert {:ok, %Topic{} = topic} = Forums.update_topic(topic, update_attrs)
      assert topic.body == "some updated body"
      assert topic.title == "some updated title"
    end

    test "update_topic/2 with invalid data returns error changeset" do
      topic = topic_fixture()
      assert {:error, %Ecto.Changeset{}} = Forums.update_topic(topic, @invalid_attrs)
      assert topic == Forums.get_topic!(topic.id)
    end

    test "delete_topic/1 deletes the topic" do
      topic = topic_fixture()
      assert {:ok, %Topic{}} = Forums.delete_topic(topic)
      assert_raise Ecto.NoResultsError, fn -> Forums.get_topic!(topic.id) end
    end

    test "change_topic/1 returns a topic changeset" do
      topic = topic_fixture()
      assert %Ecto.Changeset{} = Forums.change_topic(topic)
    end
  end

  describe "replies" do
    alias ElxrBB.Forums.Reply

    import ElxrBB.ForumsFixtures

    @invalid_attrs %{body: nil}

    test "list_replies/0 returns all replies" do
      reply = reply_fixture()
      assert Forums.list_replies() == [reply]
    end

    test "get_reply!/1 returns the reply with given id" do
      reply = reply_fixture()
      assert Forums.get_reply!(reply.id) == reply
    end

    test "create_reply/1 with valid data creates a reply" do
      valid_attrs = %{body: "some body"}

      assert {:ok, %Reply{} = reply} = Forums.create_reply(valid_attrs)
      assert reply.body == "some body"
    end

    test "create_reply/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forums.create_reply(@invalid_attrs)
    end

    test "update_reply/2 with valid data updates the reply" do
      reply = reply_fixture()
      update_attrs = %{body: "some updated body"}

      assert {:ok, %Reply{} = reply} = Forums.update_reply(reply, update_attrs)
      assert reply.body == "some updated body"
    end

    test "update_reply/2 with invalid data returns error changeset" do
      reply = reply_fixture()
      assert {:error, %Ecto.Changeset{}} = Forums.update_reply(reply, @invalid_attrs)
      assert reply == Forums.get_reply!(reply.id)
    end

    test "delete_reply/1 deletes the reply" do
      reply = reply_fixture()
      assert {:ok, %Reply{}} = Forums.delete_reply(reply)
      assert_raise Ecto.NoResultsError, fn -> Forums.get_reply!(reply.id) end
    end

    test "change_reply/1 returns a reply changeset" do
      reply = reply_fixture()
      assert %Ecto.Changeset{} = Forums.change_reply(reply)
    end
  end
end

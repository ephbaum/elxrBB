defmodule ElxrBB.ForumsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElxrBB.Forums` context.
  """

  @doc """
  Generate a forum.
  """
  def forum_fixture(attrs \\ %{}) do
    {:ok, forum} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title"
      })
      |> ElxrBB.Forums.create_forum()

    forum
  end

  @doc """
  Generate a topic.
  """
  def topic_fixture(attrs \\ %{}) do
    {:ok, topic} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title"
      })
      |> ElxrBB.Forums.create_topic()

    topic
  end
end

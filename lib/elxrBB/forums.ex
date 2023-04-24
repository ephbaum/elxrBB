defmodule ElxrBB.Forums do
  @moduledoc """
  The Forums context.
  """

  import Ecto.Query, warn: false
  alias ElxrBB.Repo

  alias ElxrBB.Forums.Forum

  @doc """
  Returns the list of forums.

  ## Examples

      iex> list_forums()
      [%Forum{}, ...]

  """
  def list_forums do
    Repo.all(Forum)
  end

  @doc """
  Gets a single forum.

  Raises `Ecto.NoResultsError` if the Forum does not exist.

  ## Examples

      iex> get_forum!(123)
      %Forum{}

      iex> get_forum!(456)
      ** (Ecto.NoResultsError)

  """
  def get_forum!(id), do: Repo.get!(Forum, id)

  @doc """
  Creates a forum.

  ## Examples

      iex> create_forum(%{field: value})
      {:ok, %Forum{}}

      iex> create_forum(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_forum(attrs \\ %{}) do
    %Forum{}
    |> Forum.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a forum.

  ## Examples

      iex> update_forum(forum, %{field: new_value})
      {:ok, %Forum{}}

      iex> update_forum(forum, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_forum(%Forum{} = forum, attrs) do
    forum
    |> Forum.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a forum.

  ## Examples

      iex> delete_forum(forum)
      {:ok, %Forum{}}

      iex> delete_forum(forum)
      {:error, %Ecto.Changeset{}}

  """
  def delete_forum(%Forum{} = forum) do
    Repo.delete(forum)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking forum changes.

  ## Examples

      iex> change_forum(forum)
      %Ecto.Changeset{data: %Forum{}}

  """
  def change_forum(%Forum{} = forum, attrs \\ %{}) do
    Forum.changeset(forum, attrs)
  end

  alias ElxrBB.Forums.Topic

  @doc """
  Returns the list of topics.

  ## Examples

      iex> list_topics()
      [%Topic{}, ...]

  """
  def list_topics do
    Repo.all(Topic)
  end

  @doc """
  Gets a single topic.

  Raises `Ecto.NoResultsError` if the Topic does not exist.

  ## Examples

      iex> get_topic!(123)
      %Topic{}

      iex> get_topic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_topic!(id), do: Repo.get!(Topic, id)

  @doc """
  Creates a topic.

  ## Examples

      iex> create_topic(%{field: value})
      {:ok, %Topic{}}

      iex> create_topic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_topic(attrs \\ %{}) do
    %Topic{}
    |> Topic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a topic.

  ## Examples

      iex> update_topic(topic, %{field: new_value})
      {:ok, %Topic{}}

      iex> update_topic(topic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_topic(%Topic{} = topic, attrs) do
    topic
    |> Topic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a topic.

  ## Examples

      iex> delete_topic(topic)
      {:ok, %Topic{}}

      iex> delete_topic(topic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_topic(%Topic{} = topic) do
    Repo.delete(topic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking topic changes.

  ## Examples

      iex> change_topic(topic)
      %Ecto.Changeset{data: %Topic{}}

  """
  def change_topic(%Topic{} = topic, attrs \\ %{}) do
    Topic.changeset(topic, attrs)
  end

  alias ElxrBB.Forums.Reply

  @doc """
  Returns the list of replies.

  ## Examples

      iex> list_replies()
      [%Reply{}, ...]

  """
  def list_replies do
    Repo.all(Reply)
  end

  @doc """
  Gets a single reply.

  Raises `Ecto.NoResultsError` if the Reply does not exist.

  ## Examples

      iex> get_reply!(123)
      %Reply{}

      iex> get_reply!(456)
      ** (Ecto.NoResultsError)

  """
  def get_reply!(id), do: Repo.get!(Reply, id)

  @doc """
  Creates a reply.

  ## Examples

      iex> create_reply(%{field: value})
      {:ok, %Reply{}}

      iex> create_reply(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_reply(attrs \\ %{}) do
    %Reply{}
    |> Reply.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a reply.

  ## Examples

      iex> update_reply(reply, %{field: new_value})
      {:ok, %Reply{}}

      iex> update_reply(reply, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_reply(%Reply{} = reply, attrs) do
    reply
    |> Reply.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a reply.

  ## Examples

      iex> delete_reply(reply)
      {:ok, %Reply{}}

      iex> delete_reply(reply)
      {:error, %Ecto.Changeset{}}

  """
  def delete_reply(%Reply{} = reply) do
    Repo.delete(reply)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking reply changes.

  ## Examples

      iex> change_reply(reply)
      %Ecto.Changeset{data: %Reply{}}

  """
  def change_reply(%Reply{} = reply, attrs \\ %{}) do
    Reply.changeset(reply, attrs)
  end
end

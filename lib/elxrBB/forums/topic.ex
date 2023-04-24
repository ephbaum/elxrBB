defmodule ElxrBB.Forums.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :body, :string
    field :title, :string
    field :forum_id, :id

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end

defmodule ElxrBB.Forums.Forum do
  use Ecto.Schema
  import Ecto.Changeset

  schema "forums" do
    field :description, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(forum, attrs) do
    forum
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end

defmodule ElxrBB.Forums.Reply do
  use Ecto.Schema
  import Ecto.Changeset

  schema "replies" do
    field :body, :string
    field :topic_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(reply, attrs) do
    reply
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end

defmodule ElxrBB.Repo.Migrations.CreateReplies do
  use Ecto.Migration

  def change do
    create table(:replies) do
      add :body, :text
      add :topic_id, references(:topics, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:replies, [:topic_id])
    create index(:replies, [:user_id])
  end
end

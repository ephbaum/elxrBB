defmodule ElxrBB.Repo.Migrations.CreateTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :title, :string
      add :body, :text
      add :forum_id, references(:forums, on_delete: :nothing)

      timestamps()
    end

    create index(:topics, [:forum_id])
  end
end

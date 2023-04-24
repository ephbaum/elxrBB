defmodule ElxrBB.Repo.Migrations.CreateForums do
  use Ecto.Migration

  def change do
    create table(:forums) do
      add :title, :string
      add :description, :text

      timestamps()
    end
  end
end

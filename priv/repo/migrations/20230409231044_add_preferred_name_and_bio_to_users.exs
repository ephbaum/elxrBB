defmodule ElxrBB.Repo.Migrations.AddPreferredNameAndBioToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :preferred_name, :string
      add :bio, :string
    end
  end
end

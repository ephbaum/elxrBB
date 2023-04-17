defmodule ElxrBB.Repo.Migrations.AddUserameAndBioToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string
      add :bio, :string
    end
  end
end

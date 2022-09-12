defmodule FinalProject.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :string
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end
  end
end

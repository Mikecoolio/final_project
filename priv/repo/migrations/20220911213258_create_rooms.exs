defmodule FinalProject.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      add :description, :string
      add :room_indentifier, :string
      add :user_id, references(:users, on_delete: :delete_all), null: false
      timestamps()
    end
    create unique_index(:rooms, [:user_id, :name])
  end
end

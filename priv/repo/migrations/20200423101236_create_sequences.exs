defmodule Chronoquants.Repo.Migrations.CreateSequences do
  use Ecto.Migration

  def change do
    create table(:sequences) do
      add :name, :string
      add :public, :boolean, default: false, null: false
      add :summary, :text
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:sequences, [:user_id])
  end
end

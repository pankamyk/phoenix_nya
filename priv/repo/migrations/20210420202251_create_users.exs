defmodule Nya.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username,      :string
      add :email,         :string
      add :password_hash, :string
      add :is_admin, :boolean, default: false, null: false

      timestamps([type: :utc_datetime_usec])
    end

    create unique_index(:users, [:email])
  end
end

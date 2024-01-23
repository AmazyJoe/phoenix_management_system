defmodule System2.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :password, :string
      add :department_id, references(:departments, on_delete: :nothing)
      add :department, :string
      timestamps(type: :utc_datetime)
    end

    create index(:users, [:department_id])
  end
end

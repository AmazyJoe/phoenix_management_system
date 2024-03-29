defmodule System2.HR.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password, :string  # Change this line
    field :department_id, :id
    field :department, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password])  # And change here
    |> validate_required([:first_name, :last_name, :email, :password])
  end
end

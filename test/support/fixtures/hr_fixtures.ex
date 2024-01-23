defmodule System2.HRFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `System2.HR` context.
  """

  @doc """
  Generate a department.
  """
  def department_fixture(attrs \\ %{}) do
    {:ok, department} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> System2.HR.create_department()

    department
  end

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        first_name: "some first_name",
        last_name: "some last_name",
        password_hash: "some password_hash"
      })
      |> System2.HR.create_user()

    user
  end
end

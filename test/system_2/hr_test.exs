defmodule System2.HRTest do
  use System2.DataCase

  alias System2.HR

  describe "departments" do
    alias System2.HR.Department

    import System2.HRFixtures

    @invalid_attrs %{name: nil}

    test "list_departments/0 returns all departments" do
      department = department_fixture()
      assert HR.list_departments() == [department]
    end

    test "get_department!/1 returns the department with given id" do
      department = department_fixture()
      assert HR.get_department!(department.id) == department
    end

    test "create_department/1 with valid data creates a department" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Department{} = department} = HR.create_department(valid_attrs)
      assert department.name == "some name"
    end

    test "create_department/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HR.create_department(@invalid_attrs)
    end

    test "update_department/2 with valid data updates the department" do
      department = department_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Department{} = department} = HR.update_department(department, update_attrs)
      assert department.name == "some updated name"
    end

    test "update_department/2 with invalid data returns error changeset" do
      department = department_fixture()
      assert {:error, %Ecto.Changeset{}} = HR.update_department(department, @invalid_attrs)
      assert department == HR.get_department!(department.id)
    end

    test "delete_department/1 deletes the department" do
      department = department_fixture()
      assert {:ok, %Department{}} = HR.delete_department(department)
      assert_raise Ecto.NoResultsError, fn -> HR.get_department!(department.id) end
    end

    test "change_department/1 returns a department changeset" do
      department = department_fixture()
      assert %Ecto.Changeset{} = HR.change_department(department)
    end
  end

  describe "users" do
    alias System2.HR.User

    import System2.HRFixtures

    @invalid_attrs %{first_name: nil, last_name: nil, email: nil, password_hash: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert HR.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert HR.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{first_name: "some first_name", last_name: "some last_name", email: "some email", password_hash: "some password_hash"}

      assert {:ok, %User{} = user} = HR.create_user(valid_attrs)
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.email == "some email"
      assert user.password_hash == "some password_hash"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HR.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{first_name: "some updated first_name", last_name: "some updated last_name", email: "some updated email", password_hash: "some updated password_hash"}

      assert {:ok, %User{} = user} = HR.update_user(user, update_attrs)
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.email == "some updated email"
      assert user.password_hash == "some updated password_hash"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = HR.update_user(user, @invalid_attrs)
      assert user == HR.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = HR.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> HR.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = HR.change_user(user)
    end
  end
end

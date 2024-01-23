defmodule System2Web.DepartmentControllerTest do
  use System2Web.ConnCase

  import System2.HRFixtures

  alias System2.HR.Department

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all departments", %{conn: conn} do
      conn = get(conn, ~p"/api/departments")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create department" do
    test "renders department when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/departments", department: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/departments/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/departments", department: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update department" do
    setup [:create_department]

    test "renders department when data is valid", %{conn: conn, department: %Department{id: id} = department} do
      conn = put(conn, ~p"/api/departments/#{department}", department: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/departments/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, department: department} do
      conn = put(conn, ~p"/api/departments/#{department}", department: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete department" do
    setup [:create_department]

    test "deletes chosen department", %{conn: conn, department: department} do
      conn = delete(conn, ~p"/api/departments/#{department}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/departments/#{department}")
      end
    end
  end

  defp create_department(_) do
    department = department_fixture()
    %{department: department}
  end
end

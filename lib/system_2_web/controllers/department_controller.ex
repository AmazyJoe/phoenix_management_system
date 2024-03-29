defmodule System2Web.DepartmentController do
  use System2Web, :controller

  alias System2.HR
  alias System2.HR.Department

  action_fallback System2Web.FallbackController

  def index(conn, _params) do
    departments = HR.list_departments()
    render(conn, :index, departments: departments)
  end

  def create(conn, %{"department" => department_params}) do
    with {:ok, %Department{} = department} <- HR.create_department(department_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/departments/#{department}")
      |> render(:show, department: department)
    end
  end

  def show(conn, %{"id" => id}) do
    department = HR.get_department!(id)
    render(conn, :show, department: department)
  end

  def update(conn, %{"id" => id, "department" => department_params}) do
    department = HR.get_department!(id)

    with {:ok, %Department{} = department} <- HR.update_department(department, department_params) do
      render(conn, :show, department: department)
    end
  end

  def delete(conn, %{"id" => id}) do
    department = HR.get_department!(id)

    with {:ok, %Department{}} <- HR.delete_department(department) do
      send_resp(conn, :no_content, "")
    end
  end
end

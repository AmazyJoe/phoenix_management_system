defmodule System2Web.UserController do
  use System2Web, :controller

  alias System2.HR
  alias System2.HR.User

  action_fallback System2Web.FallbackController

  def index(conn, _params) do
    users = HR.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- HR.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = HR.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = HR.get_user!(id)

    with {:ok, %User{} = user} <- HR.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = HR.get_user!(id)

    with {:ok, %User{}} <- HR.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end

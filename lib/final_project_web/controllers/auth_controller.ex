defmodule FinalProjectWeb.AuthController do
  use FinalProjectWeb, :controller
  import Plug.Conn

  alias FinalProject.Auth
  alias FinalProject.Auth.User
  alias FinalProjectWeb.Utils
  alias FinalProjectWeb.Constants

  plug :prevent_exploits when action in [:login, :register]
  plug :prevent_consecutive_unauthorized_actions when action in [:logout, :get_current_logged_in_user]

  def test(conn, _params) do
    render(conn, "acknowledge.json", %{message: "hello testing"})
  end

  def new_login(conn, _) do
    render(conn, "new.html", error_message: nil)
  end

  # https://hexdocs.pm/phoenix_html/2.14.3/Phoenix.HTML.Form.html#module-with-changeset-data

  def register(conn, params) do
    case Auth.create_user(params) do
      {:ok, _} ->
        render(conn, "acknowledge.json", %{message: "User Registered!"})

        {:error, changeset} ->
          render(conn, "errors.json", %{
           errors: Utils.format_changeset_errors(changeset)
        })

        {_, _} ->
          render(conn, "errors.json", %{message: Constants.internal_server_error()})
    end
  end

  def login(conn, params) do
    IO.inspect(params)
    # IO.puts("conn: ")
    # IO.inspect(conn)

    # IO.puts("params: ")
    # IO.inspect(params)

    # conn
    case User.login_changeset(params) do
      %Ecto.Changeset{valid?: true,
      changes:
        %{username: username,
          password: password
      }} ->
      user = Auth.get_by_username(username)

      case user do
        %User{} ->
          if Argon2.verify_pass(password, user.password) do
            conn
            |> put_status(:created)
            |> put_session(:current_user_id, user.id)
            |> redirect(to: "/show_all_users")
            # |> render("acknowledge.json", %{message: "Logged In"})

            # IO.puts("conn")
            # IO.inspect(conn)

            # IO.puts("user")
            # IO.inspect(user)
          else
            render(conn, "errors.json", %{errors: Constants.invalid_credentials()})
          end

        _ ->
          render(conn, "errors.json", %{errors: Constants.invalid_credentials()})
      end

    # {%Ecto.Changeset{valid?: false} = changeset} ->
    {:error, %Ecto.Changeset{} = changeset} ->
      render(conn, "errors.json", %{
        errors: Utils.format_changeset_errors(changeset)
      })

    {_, _} ->
      render(conn, "errors.json", %{message: Constants.internal_server_error()})
    end
  end

  def logout(conn, _params) do
    conn
    |> Plug.Conn.clear_session()
    |> redirect(to: "/")
    # |> render("acknowledge.json", %{message: "Logged Out"})
  end

  def get_current_logged_in_user(conn, _params) do
    render(conn, "get_current_logged_in_user.json", %{current_user: conn.assigns.current_user })
  end

  # https://hexdocs.pm/plug/Plug.Conn.html#module-request-fields
  # if the user is signed in then keep the connection else close the connection
  defp prevent_consecutive_unauthorized_actions(conn, _params) do
    if conn.assigns.user_signed_in? do
      conn
    else
      send_resp(conn, 401, Constants.not_authenticated())

      conn
      |> halt()
    end
  end

  defp prevent_exploits(conn, _params) do
    if conn.assigns.user_signed_in? do
      send_resp(conn, 401, Constants.not_authorized())

      conn
      |> halt()
    else
      IO.puts("conn")
      IO.inspect(conn)
      conn
    end
  end
end

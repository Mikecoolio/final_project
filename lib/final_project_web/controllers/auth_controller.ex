defmodule FinalProjectWeb.AuthController do
  use FinalProjectWeb, :controller
  import Plug.Conn

  alias FinalProject.Auth
  alias FinalProject.Auth.User
  alias FinalProjectWeb.Utils
  alias FinalProjectWeb.Constants


  def test(conn, _params) do
    render(conn, "acknowledge.json", %{message: "hello testing"})
  end

  def register(conn, params) do
    case Auth.create_user(params) do
      {:ok, _} ->
        render(conn, "acknowledge.json", %{message: "User Registered!"})

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "errors.json", %{
           errors: Utils.format_changeset_errors(changeset)
        })

        {_, _} ->
          render(conn, "errors.json", %{message: Constants.internal_server_error()})
    end
  end

  def login(conn, params) do
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
            |> render("acknowledge.json", %{message: "Logged In"})

          else
            render(conn, "errors.json", %{errors: Constants.invalid_credentials()})
          end

        _ ->
          render(conn, "errors.json", %{errors: Constants.invalid_credentials()})
      end


      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "errors.json", %{
          errors: Utils.format_changeset_errors(changeset)
        })

      {_, _} ->
        render(conn, "errors.json", %{message: Constants.internal_server_error()})
    end
  end
end

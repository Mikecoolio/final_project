defmodule FinalProjectWeb.PageController do
  use FinalProjectWeb, :controller

  # alias FinalProject.Auth
  # alias FinalProject.Auth.User
  # alias FinalProjectWeb.FormatErrorMessages
  # alias FinalProjectWeb.ErrorMessages

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def register(conn, params) do
    IO.puts("params: ")
    IO.inspect(params)

    render(conn, "register.html", error_message: nil)
  #   case Auth.create_user(params) do
  #     {:ok, _} ->
  #       render(conn, "acknowledge.json", %{message: "User Registered!"})

  #       # {:error, changeset} ->
  #       #   render(conn, "errors.json", %{
  #       #    errors: FormatErrorMessages.format_changeset_errors(changeset)
  #       # })

  #       {_, _} ->
  #         render(conn, "errors.json", %{message: ErrorMessages.internal_server_error()})
  #   end
  # end
  end
end

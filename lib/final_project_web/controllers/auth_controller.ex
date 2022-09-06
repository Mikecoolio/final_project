defmodule FinalProjectWeb.AuthController do
  use FinalProjectWeb, :controller

  alias FinalProject.Auth
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
           success: false,
           errors: Utils.format_changeset_errors(changeset)
        })

        {_, _} ->
          render(conn, "errors.json", %{success: false, message: Constants.internal_server_error()})
    end
  end


end

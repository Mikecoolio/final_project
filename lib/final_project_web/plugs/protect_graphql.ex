defmodule FinalProjectWeb.Plugs.ProtectGraphQL do
  import Plug.Conn

  alias FinalProject.Auth
  alias FinalProject.Auth.User
  alias FinalProjectWeb.Constants

  def init(_params) do
  end

  def call(conn, _params) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    # the above line references the user_id to grab the user

    if user_id do
      user = Auth.get_user!(user_id)

      case user do
        %User{} ->
          conn
          |> assign(:user_signed_in?, true)
          |> assign(:current_user, user)

        _ ->
          send_resp(conn, 401, Constants.not_authenticated())
          conn
          |> halt()
      end
    else
      conn
      |> assign(:user_signed_in?, false)
      |> assign(:current_user, nil)
    end
  end
end

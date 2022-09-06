defmodule FinalProjectWeb.Plugs.PopulateAuth do
  import Plug.Conn

  alias FinalProject.Auth
  alias FinalProject.Auth.User

  def init(params) do
    # IO.puts("params inside populate_auth.ex's init")
    # IO.inspect(params)
    # the params is empty in init(params)
  end

  def call(conn, _params) do
    IO.puts("conn inside call() populate_auth.ex:")
    IO.inspect(conn)

    user_id = Plug.Conn.get_session(conn, :current_user_id)

    if user_id do
      user = Auth.get_user!(user_id)

      case user do
        %User{} ->
          conn
          |> assign(:user_signed_in?, true)
          |> assign(:current_user, user)

        _ ->
          conn
          |> assign(:user_signed_in?, false)
          |> assign(:current_user, nil)
      end
    else
      conn
      |> assign(:user_signed_in?, false)
      |> assign(:current_user, nil)
    end
  end
end

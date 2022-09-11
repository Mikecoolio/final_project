defmodule FinalProjectWeb.Plugs.PopulateAuth do
  import Plug.Conn

  alias FinalProject.Auth
  alias FinalProject.Auth.User

  def init(params) do
    # IO.puts("params inside populate_auth.ex's init")
    # IO.inspect(params)
    # the params is empty in init(params)
  end

  def call(conn, params) do
    IO.puts("params inside call() populate_auth.ex:")
    IO.inspect(params)

    IO.puts("conn inside call() populate_auth.ex:")
    IO.inspect(conn)

    # IO.puts("Plug.Conn.fetch_query_params(conn) inside call() populate_auth.ex:")
    # IO.inspect(Plug.Conn.fetch_query_params(conn))

  user_id = Plug.Conn.get_session(conn, :current_user_id)

    IO.puts("user_id inside call() populate_auth.ex:")
    IO.inspect(user_id)

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

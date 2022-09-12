defmodule FinalProjectWeb.Plugs.ProtectGraphQL do
  import Plug.Conn

  alias FinalProject.Auth
  alias FinalProject.Auth.User
  alias FinalProjectWeb.ErrorMessages

  def init(_params) do
  end

  def call(conn, _params) do
    # IO.puts("conn inside call in protext_graphql.ex:")
    # IO.inspect(conn)

    user_id = Plug.Conn.get_session(conn, :current_user_id)
    # the above line references the user_id to grab the user

    if user_id do
      user = Auth.get_user!(user_id)

      case user do
        %User{} ->
          conn
          # |> assign(:user_signed_in?, true)
          # |> assign(:current_user, user)
          |> Absinthe.Plug.put_options(context: %{current_user: user})

        _ ->
          send_resp(conn, 401, ErrorMessages.not_authenticated())
          conn
          |> halt()
      end
    else # when no user_id is found then close the connection because the user has been logged out/disconnected
      send_resp(conn, 401, ErrorMessages.not_authenticated())

      conn
      |> halt()
    end
  end
end

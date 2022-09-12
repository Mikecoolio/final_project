# defmodule FinalProjectWeb.Plugs.Redirector do
#   # redirects logged in users
#   alias FinalProjectWeb.Router.Helpers, as: Routes
#   import Phoenix.Controller, only: [redirect: 2]

#   def init(opts) do
#     opts
#   end

#   def call(%Plug.Conn{assigns: assigns} = conn, opts) do
#     case assigns do
#       %{id: id} when not is_nil(id) ->
#         redirect(conn, to: Routes.live_path(conn, :show, "show_users"))

#       _ ->
#         conn
#     end
#   end
# end

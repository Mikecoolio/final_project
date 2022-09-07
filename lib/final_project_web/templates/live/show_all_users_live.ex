defmodule FinalProjectWeb.ShowAllUsersLive do
  use FinalProjectWeb, :live_view

  alias FinalProject.Auth

  def mount(_params, session, socket) do
    IO.puts("users:")
    # @users = Auth.list_users()
    users = Auth.list_users()
    IO.inspect(length(users))
    user_length = length(users)

    IO.puts("socket inside show-all-users-live:")
    IO.inspect(socket)

    IO.puts("session inside show-all-users-live:")
    IO.inspect(session)

    if map_size(session) > 1 do
      session_map = Map.values(session)
      current_logged_id = List.last(session_map)

      IO.inspect(current_logged_id, label: "current_logged_id")
      socket = assign(socket, users_length: user_length, users: Auth.list_users(), current_logged_user_id: current_logged_id, no_user_logged_in: nil)
      {:ok, socket}
    else
      session_map = Map.values(session)
      only_csrf_token_in_session = List.last(session_map)

      socket = assign(socket, users_length: user_length, users: Auth.list_users(), no_user_logged_in: only_csrf_token_in_session, current_logged_user_id: nil)
      {:ok, socket}
    end
  end

  def render(assigns) do
    ~H"""
    <head>
      <link rel="stylesheet" href="assets/css/app.css">
    </head>
    <body>
      <div class="centerme">

        <h1>Show All Users Page</h1>

        <%= if @no_user_logged_in != nil do %>
          <p>No User Is Logged In Yet</p>
          <li><a href="/">Login To Acccount</a></li>
          <li><a href="/">Register A New Account</a></li>
        <% else %>
          <form action="/api/auth/logout" method="POST">
            <input type="hidden" name="_method" value="DELETE" />
            <input type="hidden" name="_token" value="{{ csrf_token() }}">
            <input type="submit" value="Log Out">
          </form>
          <p> The Username for the Currently Logged In User is: </p>
          <%= for user <- @users, user.id === @current_logged_user_id do %>
            <li>
              <%= link(user.username, to: "/show_currently_logged_in_user", data: user.username) %>
            </li>
          <% end %>
        <% end %>

        <span>
          There are currently
          <strong><%= @users_length %></strong> users already registered.
        </span>

        <p>
          <strong>
            <ul>
              <p> These are all of the usernames registered: </p>
                <%= for user <- @users do %>
              <li>
                <%#= link(user.username, to: "/show_currently_logged_in_user", data: user.username) %>
                <%= user.username %>
              </li>
                <% end %>
              </ul>
          </strong>
        </p>
      </div>
    </body>
    """
  end
end

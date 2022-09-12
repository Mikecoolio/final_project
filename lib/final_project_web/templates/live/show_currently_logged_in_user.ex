defmodule FinalProjectWeb.ShowCurrentlyLoggedInUser do
  use FinalProjectWeb, :live_view
  alias FinalProject.Auth
  # session carries the current id
  def mount(_params, session, socket) do
    # IO.puts("params inside show single user:")
    # IO.inspect(params)

    # IO.puts("session inside show single user:")
    # IO.inspect(session)

    session_map = Map.values(session)
    current_logged_id = List.last(session_map)

    # IO.puts("current_logged_id inside show single user:")
    # IO.inspect(current_logged_id)

    get_entire_user = Auth.get_user!(current_logged_id)
    # IO.puts("get_entire_user")
    # IO.inspect(get_entire_user)

    socket = assign(socket, current_logged_id: current_logged_id, current_logged_in_user: get_entire_user)
    {:ok, socket}
  end


  def render(assigns) do
    ~L"""
      <head>
        <link rel="stylesheet" href="assets/css/app.css">
      </head>
      <div class="centerme">
        <form action="/api/auth/logout" method="POST">
          <input type="hidden" name="_method" value="DELETE" />
          <input type="hidden" name="_token" value="{{ csrf_token() }}">
          <input type="submit" value="Log Out">
        </form>

        <h1> Hello <%= @current_logged_in_user.username %> </h1>
        <p><%= @current_logged_in_user.username %>'s ID:
          <strong><%= @current_logged_id %></strong>
        </p>
        <%#= for user <- @users, user.id === @current_logged_user_id do %>

        <h3> Email: </h3>
        <li>
          <%= @current_logged_in_user.email %>
        </li>

        <h3> Account Registration Time: </h3>
        <li>
          <%= @current_logged_in_user.inserted_at %>
        </li>

        <%= link("Edit", to: "/edit_user") %>
      </a>
      </div>
    """
  end
end

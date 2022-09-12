defmodule FinalProjectWeb.ChatMessagesLive do
  use FinalProjectWeb, :live_view

  # alias FinalProject.Auth
  # alias FinalProject.Auth.User

  on_mount {FinalProjectWeb.AuthController, :current_user}

  def mount(_params, _session, socket) do
    %{current_user: current_user} = socket.assigns

    if connected?(socket) do
      FinalProject.Chatrooms.subscribe(current_user.id)
    end

    socket =
      socket
      |>
      assign(
        current_user_id: current_user.id,
        name: current_user.username
      )

      {:ok, socket, current_user: current_user}
  end

  def render(assigns) do
    ~H"""
      <p>Chat Messages Live Page</p>
      <p>User id: <%= @current_user.id %> </p>
    """
  end
end

defmodule FinalProjectWeb.PageController do
  use FinalProjectWeb, :controller
  alias FinalProject.Chatrooms
  # alias FinalProject.Auth
  # alias FinalProject.Auth.User
  # alias FinalProjectWeb.FormatErrorMessages
  # alias FinalProjectWeb.ErrorMessages

  def index(conn, _params) do
    messages = Chatrooms.list_messages()
    render(conn, "index.html", messages: messages)
  end

  def register(conn, _params) do
    # IO.puts("params inside /page_controller#register: ")
    # IO.inspect(params)

    # IO.inspect("conn inside /page_controller#register: ")
    # IO.inspect(conn)

    render(conn, "register.html", error_message: nil)
  end
end

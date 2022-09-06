defmodule FinalProjectWeb.AuthController do
  use FinalProjectWeb, :controller

  def index(conn, _params) do
    render(conn, "acknowledge.json", %{message: "hello testing"})
  end

  # def register(conn, params) do

  # end

  
end

defmodule FinalProjectWeb.AuthView do
  use FinalProjectWeb, :view

  def render("acknowledge.json", %{message: message}) do
    %{success: true, message: message}
  end

  def render("errors.json", %{errors: errors}) do
    %{success: false, errors: errors}
  end

  def render("get_current_logged_in_user.json", %{current_user: current_user}) do
    %{
      success: true,
      data: %{
        id: current_user.id,
        username: current_user.username,
        email: current_user.email,
        inserted_at: current_user.inserted_at
      }
    }
  end
end

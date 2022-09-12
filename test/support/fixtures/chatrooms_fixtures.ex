defmodule FinalProject.ChatroomsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FinalProject.Chatrooms` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        body: "some body",
        user_id: 42
      })
      |> FinalProject.Chatrooms.create_message()

    message
  end
end

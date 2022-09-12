defmodule FinalProject.ChatroomsTest do
  use FinalProject.DataCase

  alias FinalProject.Chatrooms

  describe "messages" do
    alias FinalProject.Chatrooms.Message

    import FinalProject.ChatroomsFixtures

    @invalid_attrs %{body: nil, user_id: nil}

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Chatrooms.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Chatrooms.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      valid_attrs = %{body: "some body", user_id: 42}

      assert {:ok, %Message{} = message} = Chatrooms.create_message(valid_attrs)
      assert message.body == "some body"
      assert message.user_id == 42
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chatrooms.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      update_attrs = %{body: "some updated body", user_id: 43}

      assert {:ok, %Message{} = message} = Chatrooms.update_message(message, update_attrs)
      assert message.body == "some updated body"
      assert message.user_id == 43
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Chatrooms.update_message(message, @invalid_attrs)
      assert message == Chatrooms.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Chatrooms.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Chatrooms.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Chatrooms.change_message(message)
    end
  end
end

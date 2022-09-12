defmodule FinalProjectWeb.ChatBoxChannelTest do
  use FinalProjectWeb.ChannelCase

  setup do
    {:ok, _, socket} =
      FinalProjectWeb.UserSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(FinalProjectWeb.ChatBoxChannel, "chat_box:lobby")

    %{socket: socket}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push(socket, "ping", %{"hello" => "there"})
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "shout broadcasts to chat_box:lobby", %{socket: socket} do
    push(socket, "shout", %{"hello" => "all"})
    assert_broadcast "shout", %{"hello" => "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from!(socket, "broadcast", %{"some" => "data"})
    assert_push "broadcast", %{"some" => "data"}
  end
end

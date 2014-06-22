defmodule ChatSystem.Chat.RoomTest do
  use ExUnit.Case, async: false

  setup do
    user_1  = %ChatSystem.Chat.User{name: 'One'}
    user_2  = %ChatSystem.Chat.User{name: 'Two'}

    {:ok, room} = ChatSystem.Chat.Room.start_link

    { :ok, room: room, user_1: user_1, user_2: user_2 }
  end

  test "returns list of users on join", %{room: room, user_1: user_1} do
    { :ok, list } = ChatSystem.Chat.Room.join(room, user_1)

    assert user_1 in list
  end

  test "does not allow to add same user twice", %{room: room, user_1: user_1} do
    { :ok, _ }    = ChatSystem.Chat.Room.join(room, user_1)
    { :ok, list } = ChatSystem.Chat.Room.join(room, user_1)

    assert user_1 in list
    assert length(list) == 1
  end

  test "preserves previous users on create", %{room: room, user_1: user_1, user_2: user_2} do
    { :ok, _ }    = ChatSystem.Chat.Room.join(room, user_1)
    { :ok, list } = ChatSystem.Chat.Room.join(room, user_2)

    assert user_1 in list
    assert user_2 in list

    assert length(list) == 2
  end

  test "returns message if user is in the room", %{room: room, user_1: user_1}  do
    { :ok, _ } = ChatSystem.Chat.Room.join(room, user_1)

    body = "My msg"

    { :ok, message } = ChatSystem.Chat.Room.send_message(room, user_1, body)
    assert message.body == body
    assert message.user == user_1
  end

  test "returns nil if user is not in the room", %{room: room, user_1: user_1, user_2: user_2}  do
    body = "My msg"

    { :ok, _ } = ChatSystem.Chat.Room.join(room, user_1)

    { :ok, message } = ChatSystem.Chat.Room.send_message(room, user_2, body)
    assert message == nil
  end
end

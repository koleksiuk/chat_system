defmodule ChatSystem.RoomControllerTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, collection } = ChatSystem.RoomController.start_link
    { :ok, collection: collection }
  end


  test "#get returns nil if room does not exist" do
    assert ChatSystem.RoomController.get("new_room") == nil
  end

  test "#get returns room pid if exists" do
    ChatSystem.RoomController.create("new_room")

    room = ChatSystem.RoomController.get("new_room")

    case is_pid(room) do
      true -> true
      false -> flunk "ChatSystem.RoomController#create did not return pid"
    end
  end

  test "#create creates new room if it does not exist" do
    ChatSystem.RoomController.create("new_room")

    refute ChatSystem.RoomController.get("new_room") == nil
  end

  test "#create returns room if exists" do
    room  = ChatSystem.RoomController.create("new_room")

    room2 = ChatSystem.RoomController.create("new_room")

    assert room == room2
  end

  test "#create returns pid" do
    room  = ChatSystem.RoomController.create("new_room")

    case is_pid(room) do
      true -> true
      false -> flunk "ChatSystem.RoomController#create did not return pid"
    end
  end
end

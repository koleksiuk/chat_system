defmodule ChatSystem.RoomController do
  use GenServer

  def start_link do
    Agent.start_link(fn -> Map.new end, name: __MODULE__)
  end

  def create(room_name) do
    existing_room = get(room_name)

    case existing_room do
      nil -> create_room(room_name)
      _   -> existing_room
    end
  end

  def get(room_name) do
    Agent.get(__MODULE__, &Map.get(&1, room_name))
  end

  defp create_room(room_name) do
    { :ok, room_pid } = GenServer.start_link(ChatSystem.Chat.Room, %{users: [], messages: []}, [])

    Agent.update(__MODULE__, &Map.put(&1, room_name, room_pid))

    room_pid
  end
end


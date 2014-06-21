defmodule ChatSystem.Chat.Room do
  use GenServer

  def start_link(map \\ %{users: [], messages: []}) do
    GenServer.start_link(__MODULE__, map, [])
  end

  def init(map) do
    { :ok, map }
  end
end

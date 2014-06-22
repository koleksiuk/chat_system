defmodule ChatSystem.Chat.Room do
  use GenServer

  def start_link(map \\ %{room_name: '', users: [], messages: []}) do
    GenServer.start_link(__MODULE__, map, [])
  end

  def init(map) do
    { :ok, map }
  end

  def join(room, user) do
    GenServer.call(room, { :join, user })
  end

  def send_message(room, user, message_body) do
    GenServer.call(room, { :send_message, user, message_body })
  end

  @doc """
  Adds user to a room

  Returns `{ :ok, users }` with list of users in current room
  """
  def handle_call({ :join, user }, _from, map) do
    map = update_users(user, map)

    { :reply, ok_response(map[:users]), map }
  end

  def handle_call({ :send_message, user, message }, _from, map) do
    { map, message } = create_message(user, message, map)

    { :reply, ok_response(message), map }
  end

  defp update_users(user, map) do
    case user in map[:users] do
      true  -> map
      false -> Dict.update!(map, :users, fn(users) -> [user|users] end)
    end
  end

  defp create_message(user, message_body, map) do
    case user in map[:users] do
      true  -> add_message(user, message_body, map)
      false -> { map, nil }
    end
  end

  defp add_message(user, message_body, map) do
    message = %ChatSystem.Chat.Message{body: message_body, user: user}

    { Dict.update!(map, :messages, fn(messages) -> [message|messages] end), message }
  end

  defp ok_response(response) do
    { :ok, response }
  end
end

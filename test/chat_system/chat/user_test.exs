defmodule ChatSystem.Chat.UserTest do
  use ExUnit.Case, async: true

  setup do
    user = %ChatSystem.Chat.User{}

    { :ok, user: user }
  end

  test "by default its name is empty", %{ user: user } do
    assert user.name == ""
  end

  test "by default its pid is nil", %{ user: user } do
    assert user.pid == nil
  end
end


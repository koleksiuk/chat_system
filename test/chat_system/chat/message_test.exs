defmodule ChatSystem.Chat.MessageTest do
  use ExUnit.Case, async: true

  setup do
    message = %ChatSystem.Chat.Message{}

    { :ok, message: message }
  end

  test "by default its body is empty", %{ message: message } do
    assert message.body == ""
  end

  test "by default its user is nil", %{ message: message } do
    assert message.user == nil
  end
end

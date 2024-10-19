defmodule Chatter.UsernameStore do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> ["Admin"] end, name: __MODULE__)
  end

  def unregister_username(username) when is_binary(username) do
    Agent.cast(__MODULE__, fn usernames ->
      Enum.filter(usernames, &(&1 != username))
    end)
  end

  def how_many, do: Agent.get(__MODULE__, &length/1)

  def register_username(""), do: {:error, :empty_username}

  def register_username(username) when is_binary(username) do
    Agent.update(__MODULE__, &[username | &1])
  end

  def validate_username_duplication(username) do
    current_usernames = Agent.get(__MODULE__, &Function.identity/1)

    if String.downcase(username) in Enum.map(current_usernames, &String.downcase/1) do
      {:error, :duplicate_username}
    else
      :ok
    end
  end
end

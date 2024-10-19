defmodule Chatter.ChatHistory do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def add_message(message) do
    GenServer.cast(__MODULE__, {:add, message})
  end

  def get_messages do
    GenServer.call(__MODULE__, :get)
  end

  @table :chat_history

  def init(:ok) do
    :ets.new(@table, [:named_table, :private, read_concurrency: true])
    {:ok, nil}
  end

  def handle_cast({:add, message}, state) do
    message = Map.put(message, :inserted_at, DateTime.utc_now())
    :ets.insert_new(@table, {message.id, message})
    {:noreply, state}
  end

  def handle_call(:get, _caller, state) do
    messages =
      :ets.tab2list(@table)
      |> Enum.map(&elem(&1, 1))
      |> Enum.sort_by(& &1.inserted_at, {:asc, DateTime})

    {:reply, messages, state}
  end
end

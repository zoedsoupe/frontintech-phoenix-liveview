defmodule ChatterWeb.ChatLive do
  use Phoenix.LiveView

  import Phoenix.HTML, only: [raw: 1]

  alias Phoenix.PubSub
  alias Earmark

  alias Chatter.ChatHistory
  alias Chatter.UsernameStore

  require Logger

  @topic "chat_room"

  def mount(_params, _session, socket) do
    if connected?(socket), do: PubSub.subscribe(Chatter.PubSub, @topic)

    {:ok,
     assign(socket,
       messages: ChatHistory.get_messages(),
       new_message: "",
       username: nil,
       show_username_modal: true
     )}
  end

  def handle_event("set_username", %{"username" => username}, socket) do
    sanitized_username = sanitize_username(username)

    with :ok <- UsernameStore.validate_username_duplication(sanitized_username),
         :ok <- UsernameStore.register_username(username) do
      # Broadcast uma mensagem de admin informando a entrada do novo usuário
      publish_admin_message("**#{sanitized_username}** entrou no chat!")

      {:noreply, assign(socket, username: sanitized_username, show_username_modal: false)}
    else
      error -> handle_username_registration_error(error, socket)
    end
  end

  def handle_event("send_message", %{"message" => message}, socket) do
    username = socket.assigns.username

    publish_message(username, message)

    {:noreply, assign(socket, new_message: "")}
  end

  def handle_info({:new_message, msg}, socket) do
    {:noreply, update(socket, :messages, fn msgs -> msgs ++ [msg] end)}
  end

  def render(assigns) do
    ~H"""
    <div class="chat-container">
      <!-- Modal para inserir nome de usuário -->
      <%= if @show_username_modal do %>
        <div class="modal-overlay">
          <div class="modal">
            <h2>Escolha seu Nome de Usuário</h2>
            <form phx-submit="set_username">
              <input
                type="text"
                name="username"
                placeholder="Digite seu nome de usuário..."
                autofocus
              />
              <button type="submit">Entrar</button>
            </form>
            <%= if message = @flash["error"] do %>
              <p class="error"><%= message %></p>
            <% end %>
          </div>
        </div>
      <% end %>
      <!-- Área de mensagens -->
      <div id="messages" class="messages" phx-hook="AutoScroll">
        <%= for msg <- @messages do %>
          <div class={"message #{if msg.user == "Admin", do: "admin-message"}"}>
            <strong><%= msg.user %>:</strong>
            <span class="content"><%= raw(msg.content) %></span>
          </div>
        <% end %>
      </div>
      <!-- Formulário de envio de mensagens -->
      <form id="form" phx-submit="send_message" class="message-form" phx-hook="MessageForm">
        <textarea
          name="message"
          placeholder="Digite sua mensagem..."
          autocomplete="off"
          rows="1"
          autofocus
        ></textarea>
        <button type="submit">Enviar</button>
      </form>
    </div>
    """
  end

  def terminate(_reason, socket) do
    if username = socket.assigns.username do
      UsernameStore.unregister_username(username)
      publish_admin_message("**#{username}** saiu do chat.")
    else
      :ok
    end
  end

  defp publish_admin_message(content), do: publish_message("Admin", content)

  defp publish_message(username, content) do
    message_id = generate_random_id()
    content = as_sanitized_html!(content)
    message = %{id: message_id, user: username, content: content}

    ChatHistory.add_message(message)
    PubSub.broadcast(Chatter.PubSub, @topic, {:new_message, message})
  end

  defp handle_username_registration_error({:error, :duplicate_username}, socket) do
    {:noreply,
     socket
     |> put_flash(:error, "Nome de usuário já está em uso :(")
     |> assign(:show_username_modal, true)}
  end

  defp handle_username_registration_error({:error, :empty_username}, socket) do
    {:noreply,
     socket
     |> put_flash(:error, "Nome de usuário não pode estar vazio.")
     |> assign(:show_username_modal, true)}
  end

  defp handle_username_registration_error(err, socket) do
    Logger.error("[#{__MODULE__}] => Unhandled error on username registration: #{inspect(err)}")

    {:noreply,
     socket
     |> put_flash(:error, "Aconteceu um erro interno... :/")
     |> assign(:show_username_modal, true)}
  end

  defp sanitize_username(username) when is_binary(username) do
    username
    |> String.trim()
    |> Phoenix.HTML.html_escape()
    |> Phoenix.HTML.safe_to_string()
  end

  defp as_sanitized_html!(content) when is_binary(content) do
    Earmark.as_html!(content, escape: true)
  end

  @doc """
  Gera um ID único codificado em Base64 baseado no tempo do sistema e bytes randômicos.

  ## Exemplos

      iex> generate_random_id()
      "AAECAwQFBgcICQoLDA0ODw=="

  """
  def generate_random_id do
    timestamp = :os.system_time(:nanosecond)
    timestamp_bin = <<timestamp::unsigned-64>>
    random_bytes = :crypto.strong_rand_bytes(8)
    id_binary = timestamp_bin <> random_bytes
    Base.encode64(id_binary)
  end
end

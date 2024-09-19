defmodule ChatterWeb.ChatLive do
  use Phoenix.LiveView

  import Phoenix.HTML, only: [raw: 1]

  alias Phoenix.PubSub
  alias Earmark

  @topic "chat_room"

  def mount(_params, _session, socket) do
    if connected?(socket), do: PubSub.subscribe(Chatter.PubSub, @topic)

    {:ok,
     assign(socket,
       messages: [],
       new_message: "",
       username: nil,
       show_username_modal: true
     )}
  end

  def handle_event("set_username", %{"username" => username}, socket) do
    sanitized_username = String.trim(username)

    if sanitized_username == "" do
      {:noreply,
       socket
       |> put_flash(:error, "Nome de usuário não pode estar vazio.")
       |> assign(:show_username_modal, true)}
    else
      # Broadcast uma mensagem de admin informando a entrada do novo usuário
      admin_message = %{
        id: generate_random_id(),
        user: "Admin",
        content: Earmark.as_html!("**#{sanitized_username} entrou no chat!**")
      }

      PubSub.broadcast(Chatter.PubSub, @topic, {:new_message, admin_message})

      {:noreply, assign(socket, username: sanitized_username, show_username_modal: false)}
    end
  end

  def handle_event("send_message", %{"message" => message}, socket) do
    sanitized_message = Earmark.as_html!(message)

    msg = %{
      id: generate_random_id(),
      user: socket.assigns.username,
      content: sanitized_message
    }

    PubSub.broadcast(Chatter.PubSub, @topic, {:new_message, msg})

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
            <%= if @flash[:error] do %>
              <p class="error"><%= @flash[:error] %></p>
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
        <textarea name="message" placeholder="Digite sua mensagem..." autocomplete="off" rows="1"></textarea>
        <button type="submit">Enviar</button>
      </form>
    </div>
    """
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

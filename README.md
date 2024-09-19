# Chatter & Presentation

**Chatter** é uma aplicação de sala de bate-papo em tempo real desenvolvida com **Phoenix LiveView**. Este repositório também inclui uma **apresentação** detalhando o desenvolvimento e as funcionalidades do Chatter a fim de demonstrar as vantagens do desenvolvimento web frontend com **Phoenix LiveView**. 

## 🚀 Índice

- [Visão Geral](#visão-geral)
- [Funcionalidades](#funcionalidades)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Instalação](#instalação)
  - [Rodando o Chatter com Docker](#rodando-o-chatter-com-docker)
  - [Rodando o Chatter Localmente](#rodando-o-chatter-localmente)
- [Uso](#uso)
  - [Usando o Chatter](#usando-o-chatter)
  - [Visualizando a Apresentação](#visualizando-a-apresentação)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Contribuição](#contribuição)
- [Licença](#licença)
- [Contato](#contato)
- [Recursos](#recursos)

## Visão Geral

Este repositório contém:

1. **Chatter**: Uma aplicação de chat em tempo real que permite múltiplos usuários interagirem simultaneamente com uma interface minimalista e escura, otimizada para dispositivos móveis. Suporta renderização de Markdown nas mensagens e notifica todos os usuários quando um novo participante entra na sala.

2. **Apresentação**: Um arquivo `presentation.md` que detalha o desenvolvimento da aplicação Chatter, suas funcionalidades, arquitetura e demonstração de código ao vivo.

## Funcionalidades

- **Bate-papo em Tempo Real**: Comunicação instantânea entre múltiplos usuários.
- **Escolha de Nome de Usuário**: Usuários podem definir seus próprios nomes antes de entrar no chat.
- **Renderização de Markdown**: Mensagens suportam formatação via Markdown.
- **Design Responsivo**: Interface otimizada para dispositivos móveis com tema escuro e minimalista.
- **Notificações de Entrada**: Mensagem de "Admin" informando a entrada de novos usuários.

## Tecnologias Utilizadas

- **Elixir** e **Phoenix Framework**
- **Phoenix LiveView**
- **Earmark** para renderização de Markdown
- **HTML/CSS**

## Instalação

### Rodando o Chatter Localmente

1. **Clone o repositório:**

    ```bash
    git clone https://github.com/zoedsoupe/frontintech-phoenix-liveview
    cd frontintech-phoenix-liveview/chatter
    ```

2. **Instale as dependências Elixir:**

    ```bash
    mix deps.get
    ```

3. **Inicie o servidor Phoenix:**

    ```bash
    mix phx.server
    ```

4. **Acesse a aplicação:**

    Abra `http://localhost:4000` no seu navegador.

## Uso

### Usando o Chatter

1. **Escolha um Nome de Usuário:**
   - Ao acessar a aplicação, um modal solicitará que você insira seu nome de usuário.
   - Insira um nome único e clique em "Entrar".

2. **Enviar Mensagens:**
   - Use o campo de texto na parte inferior para digitar suas mensagens.
   - Pressione `Enter` para enviar a mensagem.
   - Use `Shift+Enter` para inserir uma nova linha sem enviar a mensagem.

3. **Interação:**
   - Veja as mensagens de outros usuários aparecerem em tempo real.
   - Mensagens de "Admin" informarão quando novos usuários entrarem no chat.

### Visualizando a Apresentação

A apresentação está disponível no arquivo `presentation.md`. Para visualizar a apresentação de forma mais agradável:

1. **Usando um Visualizador Markdown:**
   - Abra o arquivo `presentation.md` em um editor de texto com suporte a Markdown, como VS Code ou Typora.

2. **Visualização Online:**

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests.

1. **Fork o repositório**
2. **Crie sua feature branch** (`git checkout -b feature/NovaFeature`)
3. **Commit suas mudanças** (`git commit -am 'Adiciona nova feature'`)
4. **Push para a branch** (`git push origin feature/NovaFeature`)
5. **Abra um Pull Request**

## Licença

Este projeto está licenciado sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 📚 Recursos

- [Documentação Oficial do Phoenix LiveView](https://hexdocs.pm/phoenix_live_view)
- [Earmark - Biblioteca de Markdown para Elixir](https://hexdocs.pm/earmark)
- [Phoenix PubSub](https://hexdocs.pm/phoenix_pubsub)
- [Guia de Hooks no Phoenix LiveView](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#module-hooks)
- [Tutorial de Phoenix LiveView](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html)

---

*Este projeto foi desenvolvido para demonstrar as capacidades do Phoenix LiveView em aplicações de tempo real, oferecendo uma experiência interativa e eficiente para os usuários.*

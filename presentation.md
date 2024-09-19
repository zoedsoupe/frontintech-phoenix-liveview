---
theme: default
title: 'Phoenix Live View: Simplificando o Front-End com Elixir'
description: Descubra como o Phoenix LiveView utiliza o Elixir para simplificar o desenvolvimento front-end, permitindo interfaces ricas e responsivas com menos código.
---

# Phoenix Live View:  
Simplificando o Front-End com Elixir

![Phoenix Logo](https://phoenixframework.org/images/phoenix.png)

---

## Sobre Mim

- **Experiência:** Desenvolvedor Front-End com [X] anos de experiência
- **Especialização:** Elixir, Phoenix, Programação Funcional

<!-- TODO INSERIR QRCODE COM INFO DE CONTATO -->

---

## Agenda

1. **Introdução ao Phoenix LiveView**
2. **Elixir e Erlang/OTP**
3. **Comparação com React, Vue e Angular**
4. **Exemplos Práticos**
5. **Vantagens e Desvantagens**
6. **Integração com Projetos Existentes**
7. **Programação Funcional**
8. **Recursos e Referências**
9. **Conclusão e Q&A**

---

## O Que é Phoenix LiveView?

- **LiveView** é uma biblioteca do **Phoenix Framework**
- Permite criar interfaces ricas e interativas sem JavaScript
- Utiliza **Elixir** e **WebSockets** para comunicação em tempo real
- Renderização no servidor com atualizações dinâmicas no cliente

---

## Elixir e Erlang/OTP

### Elixir

- Linguagem funcional, concorrente e de alto desempenho
- Executa na máquina virtual **BEAM**
- Interoperável com **Erlang**

### Erlang/OTP

- **Erlang**: Linguagem de programação funcional
- **OTP**: Conjunto de bibliotecas e design principles para construir sistemas concorrentes e distribuídos
- **BEAM VM**: Máquina virtual robusta para sistemas de alta disponibilidade

![Erlang Logo](https://www.erlang.org/images/erlang_logo.png)

---

## Programação Funcional

- **Imutabilidade:** Dados não são modificados após criação
- **Funções Puras:** Saída depende apenas das entradas
- **Concorrência:** Facilitada pela imutabilidade e modelos de ator
- **Benefícios:**
  - Código mais previsível e fácil de testar
  - Menos bugs relacionados a estados compartilhados

---

## Comparação com Frameworks JS Tradicionais

| **Característica**      | **Phoenix LiveView**      | **React/Vue/Angular**    |
|-------------------------|---------------------------|--------------------------|
| **Linguagem**           | Elixir                    | JavaScript/TypeScript    |
| **Sintaxe**             | Template Elixir (`~H`)    | JSX, Templates, HTML     |
| **Organização de Código** | Centralizado no servidor | Componentes no cliente    |
| **Tecnologia**          | WebSockets, Server-Side Rendering | HTTP/REST, SPA, WebSockets |
| **Gerenciamento de Estado** | Servidor                   | Cliente (Redux, Vuex)    |
| **Curva de Aprendizado** | Requer conhecimento de Elixir | Familiar para desenvolvedores JS |
| **SEO**                 | Melhor por renderização no servidor | Necessita de configuração adicional |

---

## Vantagens do Phoenix LiveView

- **Menor Complexidade:** Menos código JavaScript
- **Manutenção Facilitada:** Lógica centralizada no servidor
- **Performance:** Atualizações eficientes via WebSockets
- **SEO-Friendly:** Renderização no servidor
- **Desenvolvimento Rápido:** Iterações mais rápidas sem necessidade de recompilar o front-end
- **Consistência de Estado:** Estado mantido no servidor evita inconsistências

---

## Desvantagens do Phoenix LiveView

- **Dependência do Servidor:** Requer conexão constante para interações
- **Escalabilidade:** Alta demanda de conexões WebSocket pode exigir infraestrutura robusta
- **Flexibilidade:** Menos flexível para interfaces altamente interativas comparado a frameworks JS
- **Ecossistema:** Menor quantidade de bibliotecas e plugins em comparação com React/Vue

---

## Exemplos Práticos: Contador

### Código LiveView

```elixir
defmodule MyAppWeb.CounterLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :count, 0)}
  end

  def handle_event("inc", _value, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>Contador: <%= @count %></h1>
      <button phx-click="inc">Incrementar</button>
    </div>
    """
  end
end
```

![Contador LiveView](https://phoenixframework.org/images/live_view_example.png)

---

## Exemplos Práticos: Formulário Dinâmico

### Código LiveView

```elixir
defmodule MyAppWeb.FormLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :form_data, %{})}
  end

  def handle_event("validate", %{"form" => form_data}, socket) do
    {:noreply, assign(socket, :form_data, form_data)}
  end

  def render(assigns) do
    ~H"""
    <form phx-change="validate">
      <input type="text" name="form[name]" value={@form_data["name"] || ""} placeholder="Nome"/>
      <input type="email" name="form[email]" value={@form_data["email"] || ""} placeholder="Email"/>
      <button type="submit">Enviar</button>
    </form>
    <pre><%= inspect(@form_data) %></pre>
    """
  end
end
```

![Formulário LiveView](https://phoenixframework.org/images/live_view_form.png)

---

## Comparação Detalhada: LiveView vs React/Vue/Angular

### Sintaxe

- **LiveView:** Utiliza templates Elixir (`~H`), interpolação com `<%= %>`
- **React:** JSX, mistura JavaScript com HTML
- **Vue:** Templates baseados em HTML com diretivas
- **Angular:** Templates HTML com diretivas e TypeScript

### Organização de Código

- **LiveView:** Lógica no servidor, templates no cliente
- **React/Vue/Angular:** Componentes independentes com lógica e templates no cliente

### Tecnologia

- **LiveView:** WebSockets para comunicação contínua
- **React/Vue/Angular:** HTTP/REST para requisições, WebSockets opcionais

### Gerenciamento de Estado

- **LiveView:** Estado mantido no servidor
- **React/Vue/Angular:** Estado mantido no cliente com bibliotecas como Redux ou Vuex

---

## Integração com Projetos Existentes

1. **Adicionar Phoenix LiveView ao Projeto**
   ```elixir
   def deps do
     [
       {:phoenix_live_view, "~> 0.17.5"}
     ]
   end
   ```

2. **Configurar Endpoint**
   ```elixir
   socket "/live", Phoenix.LiveView.Socket
   ```

3. **Atualizar Layout**
   ```html
   <%= live_render(@conn, MyAppWeb.CounterLive) %>
   ```

4. **Adicionar Scripts no Layout**
   ```html
   <script defer type="text/javascript" src="<%= Routes.static_path(@conn, "/js/app.js") %>"></script>
   ```

---

## Programação Funcional

- **Funções de Primeira Classe:** Funções podem ser passadas como argumentos e retornadas
- **Imutabilidade:** Evita efeitos colaterais inesperados
- **Composição de Funções:** Criação de funções complexas a partir de funções simples
- **Benefícios:**
  - Código mais modular e reutilizável
  - Facilita o teste e a depuração

![Programação Funcional](https://miro.medium.com/max/1400/1*1uXG3J2B0M3U5E-4qLzvRA.png)

---

## Vantagens do LiveView

- **Desenvolvimento Rápido:** Iterações sem recompilar front-end
- **Consistência de Estado:** Estado centralizado no servidor
- **Menos Dependências:** Reduz necessidade de bibliotecas adicionais
- **SEO-Friendly:** Conteúdo renderizado no servidor
- **Facilidade de Manutenção:** Lógica unificada no backend

---

## Desempenho e Escalabilidade

- **Elixir e BEAM:** Excelente para concorrência e alta escalabilidade
- **Gerenciamento de Conexões:** Utilize **Phoenix Presence** para monitorar usuários
- **Caching:** Implementar caching para reduzir carga no servidor
- **Clusterização:** Escalar horizontalmente com múltiplos nós BEAM

---

## Recursos e Referências

- [Documentação Oficial do Phoenix LiveView](https://hexdocs.pm/phoenix_live_view)
- [Guia de Início Rápido](https://phoenixframework.org/docs/liveview)
- [Comunidade e Suporte](https://elixirforum.com/c/phoenix-liveview)
- [Livro "Programming Phoenix"](https://pragprog.com/titles/phoenix16/programming-phoenix/)
- [Curso Online de Elixir](https://www.udemy.com/course/elixir-and-phoenix-for-beginners/)

---

## Conclusão

- **Phoenix LiveView** simplifica o desenvolvimento front-end com Elixir
- Oferece **interfaces ricas e responsivas** com menos código
- Ideal para **projetos web modernos** que buscam eficiência e praticidade
- **Elixir e Programação Funcional** trazem benefícios de performance e manutenção

---

## Perguntas?

Obrigado pela atenção!  
**Contato:** seu.email@exemplo.com  
**GitHub:** [seu-usuario](https://github.com/seu-usuario)

---

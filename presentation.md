---
theme: dracula
title: 'Phoenix Live View: Simplificando o Front-End com Elixir'
description: Descubra como o Phoenix LiveView utiliza o Elixir para simplificar o desenvolvimento front-end, permitindo interfaces ricas e responsivas com menos código.
author: zoedsoupe <zoey.spessanha@zetech.io>
keywords: phoenix-liveview,spa-client-side,ssr,elixir,functional
download: true
---

# Phoenix Live View:
Simplificando o Front-End com Elixir

![Phoenix Logo](https://phoenixframework.org/images/phoenix.png)

---

## Sobre Mim

- **Pronomes:** ela/dela
- **Experiência:** Desenvolvedora Backend
- **Área de interesse:**: Fintech, Compiladores
- **Especialização:** Elixir, Clojure, React, Programação Funcional
- **Co-host:** Elixir em Foco https://elixiremfoco.com


Atualmente estou na Cumbuca!! https://cumbuca.com

---

## Agenda

1. **Elixir, seria magia?**
2. **O que seria Phoenix LiveView**
3. **Código funcional é o que funciona!**
4. **Comparação com React, Vue e Angular**
5. **Vantagens e Desvantagens**
6. **Exemplo Prático**
7. **Conclusão & Referências**
8. **Demo Show!**
9. **Q&A**

---

## Elixir, seria magia?

- Linguagem funcional e brasileira
- Baseada na VM do Erlang
- Especial em aplicações de alta disponibilidade e tolerância a falhas
- Comunidade acolhedora 💜

---

## O que seria Phoenix LiveView?

- **LiveView** é uma biblioteca do **Phoenix Framework**
- Permite criar SPAs (single page application) sem JavaScript
- Utiliza **Elixir** e **WebSockets** para comunicação em tempo real
- Renderização no servidor com atualizações dinâmicas no cliente

---

## Código funcional é o que funciona!

- **Imutabilidade:** Valores não são modificados após criação
- **Funções como valores:** Funções podem retornar outras funções ou receber outras funções como parâmetros
- **Concorrência:** Facilitada pela imutabilidade e modelos de ator
- **Benefícios:**
  - Código mais previsível e fácil de testar
  - Menos bugs relacionados a estados compartilhados
  - Sem `undefined is not a function`!!!!

---

## Comparação com Frameworks JS Tradicionais

| **Característica**      | **Phoenix LiveView**      | **React/Vue/Angular**    |
|-------------------------|---------------------------|--------------------------|
| **Linguagem**           | Elixir                    | JavaScript/TypeScript    |
| **Sintaxe**             | HEEX (HTML + Elixir)    | JSX, Templates, HTML     |
| **Tecnologia**          | WebSockets | HTTP/REST |
| **Gerenciamento de Estado** | Servidor                   | Cliente (Redux, Vuex)    |
| **Curva de Aprendizado** | Requer conhecimento de Elixir | Familiar para desenvolvedores JS |

---

## Vantagens do Phoenix LiveView

- **Manutenção Facilitada:** Lógica centralizada no servidor
- **Desenvolvimento Rápido:** Escreva pouco, contrua estruturas muito poderosas
- **Consistência de Estado:** Estado mantido no servidor evita inconsistências e duplicação de lógica de negócio
- **Flexibilidade:** Permite uso de JS no cliente via `Phoenix Hooks`

<div style="height: 45px;" />

## Desvantagens do Phoenix LiveView

- **Websocket:** Conexões de baixa qualidade podem gerar experências ruins por conta da latência
- **Ecossistema:** Menor quantidade de bibliotecas e plugins em comparação com React/Vue

> Nas versões mais recentes do LiveView, há esforço em otimizar ao máximo as atualizações enviadas pro cliente a fim de minimizar problemas de latência

---

## Exemplos Práticos: Contador

```elixir {all|4-6|8-15|17-19|all}
defmodule MyAppWeb.CounterLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :count, 0)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>Contador: <%= @count %></h1>
      <button phx-click="inc">Incrementar</button>
    </div>
    """
  end

  def handle_event("inc", _value, socket) do
    {:noreply, update(socket, :count, fn count -> count + 1 end)}
  end
end
```
---

## Conclusão

- **Phoenix LiveView** simplifica o desenvolvimento front-end com Elixir
- Ideal para **projetos web modernos** que buscam eficiência e praticidade
- **Elixir e Programação Funcional** trazem benefícios de manutenção

<div style="height: 20px;" />

### Recursos e Referências

- [Documentação Oficial do Phoenix LiveView](https://hexdocs.pm/phoenix_live_view)
- [Guia de Início Rápido](https://phoenixframework.org/docs/liveview)
- [Comunidade e Suporte](https://elixirforum.com/c/phoenix-liveview)
- [Livro "Programming Phoenix"](https://pragprog.com/titles/phoenix16/programming-phoenix/)

---
layout: center
---

## Demo show!

Vamos ter uma provinha do que o LiveView é capaz!

- chat em tempo real
- suporte a markdown

> https://chatter.zeetech.io

<img height="250" width="250" src="./assets/chatter-qrcode.png" />

Código fonte em https://github.com/zoedsoupe/frontinsampa-phoenix-liveview

---
layout: center
---

## Perguntas?

That's all folks!  

> https://zoedsoupe.zeetech.io/me

<img height="250" width="250" src="./assets/card.qrcode.png" />

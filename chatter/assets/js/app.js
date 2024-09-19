import "../css/app.css";
// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html";
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";
import topbar from "../vendor/topbar";

// Hooks
let Hooks = {};

// Hook para auto-scroll nas mensagens
Hooks.AutoScroll = {
  updated() {
    const messagesContainer = this.el;
    messagesContainer.scrollTop = messagesContainer.scrollHeight;
  },
};

// Hook para manipular o envio de mensagens com Shift+Enter
Hooks.MessageForm = {
  mounted() {
    this.el.querySelector("textarea").addEventListener("keydown", (e) => {
      if (e.key === "Enter" && !e.shiftKey) {
        e.preventDefault();
        this.pushEvent("send_message", {
          message: e.target.value,
        });
        e.target.value = "";
      }
    });
  },
  updated() {
    // Atualizar o valor do textarea após submissão
    const textarea = this.el.querySelector("textarea");
    if (textarea) {
      textarea.value = "";
    }
  },
};

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");
let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  hooks: Hooks,
  params: { _csrf_token: csrfToken },
});

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" });
window.addEventListener("phx:page-loading-start", (_info) => topbar.show(300));
window.addEventListener("phx:page-loading-stop", (_info) => topbar.hide());

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;

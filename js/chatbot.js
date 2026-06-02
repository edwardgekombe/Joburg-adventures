// Clean, working AI chat widget with backend proxy integration
(function () {
  const CHATBOT_STORAGE_KEY = 'joburg_chatbot_open_state_v1';

  function $(sel) { return document.querySelector(sel); }

  function createWidget() {
    if ($('.ai-chat-widget')) return;

    const widget = document.createElement('div');
    widget.className = 'ai-chat-widget';
    widget.setAttribute('role', 'region');
    widget.setAttribute('aria-label', 'AI travel assistant');

    widget.innerHTML = `
      <button type="button" class="ai-chat-toggle" aria-label="Open AI chat" title="Ask our AI assistant">
        <i class="fas fa-robot" aria-hidden="true"></i>
      </button>

      <div class="ai-chat-panel" aria-hidden="true">
        <div class="ai-chat-header">
          <div class="ai-chat-title">
            <i class="fas fa-bolt" aria-hidden="true"></i>
            <span>AI Assistant</span>
          </div>
          <button type="button" class="ai-chat-close" aria-label="Close AI chat" title="Close">&times;</button>
        </div>

        <div class="ai-chat-body" role="log" aria-live="polite"></div>

        <div class="ai-chat-footer">
          <div class="ai-chat-suggestions" aria-label="Quick suggestions">
            <button type="button" class="ai-chat-suggest" data-prompt="Best safari package for 3 days?">3-day safari</button>
            <button type="button" class="ai-chat-suggest" data-prompt="What’s the best time to visit Diani Beach?">Best time for Diani</button>
            <button type="button" class="ai-chat-suggest" data-prompt="Can you plan an affordable family trip in Kenya?">Family trip (budget)</button>
          </div>

          <form class="ai-chat-form" autocomplete="off">
            <input class="ai-chat-input" type="text" placeholder="Ask about safaris, beaches, prices..." />
            <button class="ai-chat-send" type="submit" aria-label="Send">
              <i class="fas fa-paper-plane" aria-hidden="true"></i>
            </button>
          </form>

          <div class="ai-chat-disclaimer">
            <small>Instant answers. For bookings, we’ll connect you to our team.</small>
          </div>
        </div>
      </div>
    `;

    document.body.appendChild(widget);

    const toggleBtn = widget.querySelector('.ai-chat-toggle');
    const panel = widget.querySelector('.ai-chat-panel');
    const closeBtn = widget.querySelector('.ai-chat-close');
    const body = widget.querySelector('.ai-chat-body');
    const form = widget.querySelector('.ai-chat-form');
    const input = widget.querySelector('.ai-chat-input');
    const sendBtn = widget.querySelector('.ai-chat-send');

    function escapeHtml(str) {
      return String(str)
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#039;');
    }

    function addMsg(role, text) {
      const msg = document.createElement('div');
      msg.className = 'ai-chat-msg ' + (role === 'user' ? 'user' : 'bot');
      msg.innerHTML = `<div class="ai-chat-bubble">${escapeHtml(text)}</div>`;
      body.appendChild(msg);
      body.scrollTop = body.scrollHeight;
    }

    function openPanel() {
      panel.classList.add('open');
      panel.setAttribute('aria-hidden', 'false');
      try { localStorage.setItem(CHATBOT_STORAGE_KEY, 'open'); } catch (_) {}
      if (body.children.length === 0) {
        addMsg('bot', 'Hi! I’m your Joburg Adventures AI assistant. Ask me about safaris, beaches, guides, or bookings.');
      }
      setTimeout(() => input && input.focus(), 50);
    }

    function closePanel() {
      panel.classList.remove('open');
      panel.setAttribute('aria-hidden', 'true');
      try { localStorage.setItem(CHATBOT_STORAGE_KEY, 'closed'); } catch (_) {}
      toggleBtn && toggleBtn.focus();
    }

    const API_HOST = ['localhost', '127.0.0.1'].includes(window.location.hostname)
      ? 'http://localhost:3000'
      : '';

    async function sendToServer(message) {
      const endpoints = ['/api/ai', `${API_HOST}/api/ai`].filter(Boolean);

      for (const endpoint of endpoints) {
        try {
          const resp = await fetch(endpoint, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ message })
          });

          if (!resp.ok) {
            if (resp.status === 404) continue;
            throw new Error(`${resp.status} ${resp.statusText}`);
          }

          const data = await resp.json();
          return data.reply || data.output || '';
        } catch (err) {
          if (endpoint === endpoints[endpoints.length - 1]) {
            console.error('AI proxy error', err);
          } else {
            console.warn(`AI proxy fallback failed for ${endpoint}`, err);
          }
        }
      }

      return null;
    }

    form.addEventListener('submit', async (e) => {
      e.preventDefault();
      const userText = (input.value || '').trim();
      if (!userText) return;

      addMsg('user', userText);
      input.value = '';
      sendBtn && (sendBtn.disabled = true);

      // show typing indicator
      const typing = document.createElement('div');
      typing.className = 'ai-chat-msg bot typing';
      typing.innerHTML = `<div class="ai-chat-bubble">...</div>`;
      body.appendChild(typing);
      body.scrollTop = body.scrollHeight;

      try {
        const reply = await sendToServer(userText);
        body.removeChild(typing);
        if (reply === null) addMsg('bot', 'Sorry—unable to reach AI service.');
        else addMsg('bot', reply + '\n\nYou can also message us on WhatsApp at +254789578168.');
      } catch (err) {
        body.removeChild(typing);
        addMsg('bot', 'Sorry—something went wrong. Please try again.');
      } finally {
        sendBtn && (sendBtn.disabled = false);
      }
    });

    toggleBtn.addEventListener('click', () => {
      if (panel.classList.contains('open')) closePanel();
      else openPanel();
    });

    closeBtn.addEventListener('click', (e) => {
      e.preventDefault();
      closePanel();
    });

    // Suggestion buttons
    widget.querySelectorAll('.ai-chat-suggest').forEach(btn => {
      btn.addEventListener('click', () => {
        const prompt = btn.getAttribute('data-prompt') || btn.textContent;
        input.value = prompt;
        form.requestSubmit();
      });
    });

    // Restore state
    try {
      const state = localStorage.getItem(CHATBOT_STORAGE_KEY);
      if (state === 'open') openPanel();
    } catch (_) {}
  }

  // Create after DOM is ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', createWidget);
  } else {
    createWidget();
  }
})();


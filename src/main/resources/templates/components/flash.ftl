<style nonce="${nonce()}">
  .flash-container {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    pointer-events: none;
    z-index: 1000;
  }
  .flash-message {
    position: relative;
    width: 100%;
    padding: 1rem 2rem;
    border-radius: 0;
    font-size: 1rem;
    font-weight: 500;
    text-align: center;
    box-shadow: none;
    animation: slideDown 0.4s ease-out;
    pointer-events: auto;
  }
  .flash-close {
    position: absolute;
    top: 0.5rem;
    right: 1rem;
    background: transparent;
    border: none;
    font-size: 1.5rem;
    line-height: 1;
    cursor: pointer;
    color: rgba(255,255,255,0.8);
  }
  .flash-close:hover {
    color: white;
  }
  @keyframes slideDown {
    0%   { opacity: 0; transform: translateY(-100%); }
    100% { opacity: 1; transform: translateY(0);    }
  }
  .flash-message.success { background: #38a169; }
  .flash-message.error   { background: #e53e3e; }
  .flash-message.warning { background: #dd6b20; }
  .flash-message.info    { background: #3182ce; }
</style>

<#if flash.has()>
  <div class="flash-container" id="flash-container">
    <div class="flash-message ${flash.type()}" id="flash-message">
      <button class="flash-close" aria-label="Fermer">&times;</button>
      ${flash.message()}
    </div>
  </div>

  <script nonce="${nonce()}">
    (function() {
      var closeBtn = document.querySelector('.flash-close');
      if (!closeBtn) return;

      closeBtn.addEventListener('click', function() {
        var container = document.getElementById('flash-container');
        if (container) {
          container.style.display = 'none';
        }
        document.cookie = 'flash_message=; max-age=0; path=/';
        document.cookie = 'flash_type=; max-age=0; path=/';
      });
    })();
  </script>
</#if>
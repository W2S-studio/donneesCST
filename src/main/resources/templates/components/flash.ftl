<style nonce="${nonce()}">
.flash-container {
  position: fixed;
  top: 0.5rem;
  left: 50%;
  transform: translateX(-50%);
  width: 100%;
  max-width: 1200px;
  pointer-events: none;
  z-index: 2000;
  padding: 0 1rem;
}

.flash-message {
  position: relative;
  width: 100%;
  padding: 1rem 3.5rem 1rem 1.5rem;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 500;
  text-align: left;
  color: white;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
  animation: slideDown 0.4s ease-out;
  pointer-events: auto;
  backdrop-filter: blur(12px);
  min-height: 3.5rem;
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  line-height: 1.5;
}

.flash-close {
  position: absolute;
  top: 50%;
  right: 1rem;
  transform: translateY(-50%);
  width: 2rem;
  height: 2rem;
  background: transparent;
  border: none;
  font-size: 1.25rem;
  cursor: pointer;
  color: rgba(255, 255, 255, 0.9);
  display: flex;
  align-items: center;
  justify-content: center;
  transition: color 0.2s ease, transform 0.2s ease;
}

.flash-close:hover {
  color: white;
  transform: translateY(-50%) scale(1.1);
}

@keyframes slideDown {
  0% { opacity: 0; transform: translateY(-100%); }
  100% { opacity: 1; transform: translateY(0); }
}

@keyframes slideUp {
  0% { opacity: 1; transform: translateY(0); }
  100% { opacity: 0; transform: translateY(-100%); }
}

.flash-message.success { background: rgba(46, 125, 50, 0.95); } /* More vibrant success color */
.flash-message.error { background: rgba(211, 47, 47, 0.95); } /* Brighter error color */
.flash-message.warning { background: rgba(255, 143, 0, 0.95); } /* More distinct warning color */
.flash-message.info { background: rgba(25, 118, 210, 0.95); } /* Cleaner info color */
.flash-message.closing {
  animation: slideUp 0.4s ease-out forwards;
}
</style>

<#if flash.has()>
  <div class="flash-container" id="flash-container">
    <div class="flash-message ${flash.type()}" id="flash-message">
      <span>${flash.message()}</span>
      <button class="flash-close" aria-label="Close">×</button>
    </div>
  </div>

  <script nonce="${nonce()}">
    (function() {
      var closeBtn = document.querySelector('.flash-close');
      var container = document.getElementById('flash-container');
      var message = document.getElementById('flash-message');
      if (!closeBtn || !container || !message) return;

      function closeFlash() {
        message.classList.add('closing');
        setTimeout(function() {
          container.style.display = 'none';
          document.cookie = 'flash_message=; max-age=0; path=/';
          document.cookie = 'flash_type=; max-age=0; path=/';
        }, 400);
      }

      setTimeout(closeFlash, 5000);
      closeBtn.addEventListener('click', closeFlash);
    })();
  </script>
</#if>
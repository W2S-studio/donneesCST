<link nonce="${nonce()}" rel="stylesheet" href="/style/components/code_preview.css">

<div class="col-lg-6">
    <div class="code-preview">
        <div class="code-header">
            <div class="code-dots">
                <span class="dot red"></span>
                <span class="dot yellow"></span>
                <span class="dot green"></span>
            </div>
            <span class="code-title">Exemple d'utilisation</span>
        </div>
        <div class="code-body">
            <pre><code id="code-content">
<!-- Initial JavaScript content -->
<span class="comment">// Récupérer des données</span>
fetch('https://api.jolt-framework.org/v1/students', {
    headers: {
        <span class="keyword">Authorization</span>: <span class="string">'Bearer ${r"${token}"}'</span>
    }
})
  .<span class="keyword">then</span>(response => response.<span class="keyword">json</span>())
  .<span class="keyword">then</span>(data => {
    console.<span class="keyword">log</span>(<span class="string">'Données reçues:'</span>, data);
  });
            </code></pre>
            <div class="language-switch">
                <select id="language-switch">
                    <option value="javascript">JavaScript</option>
                    <option value="swift">Swift</option>
                    <option value="csharp">C#</option>
                    <option value="java">Java</option>
                </select>
            </div>
        </div>
    </div>
</div>

<script nonce="${nonce()}" src="/js/components/code_preview.js"></script>
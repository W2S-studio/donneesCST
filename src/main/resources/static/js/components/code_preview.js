function switchLanguage() {
    const codeElement = document.getElementById('code-content');
    const language = document.getElementById('language-switch').value;
    let code = '';

    switch (language) {
        case 'javascript':
            code = `<span class="comment">// Récupérer des données</span>\nfetch('https://api.jolt-framework.org/v1/students', {\n    headers: {\n        <span class="keyword">Authorization</span>: <span class="string">'Bearer '</span> + token\n    }\n})\n  .<span class="keyword">then</span>(response => response.<span class="keyword">json</span>())\n  .<span class="keyword">then</span>(data => {\n    console.<span class="keyword">log</span>(<span class="string">'Données reçues:'</span>, data);\n  });`;
            break;
        case 'swift':
            code = `<span class="comment">// Récupérer des données</span>\nlet url = URL(string: <span class="string">"https://api.jolt-framework.org/v1/students"</span>)!\nlet request = URLRequest(url: url)\nrequest.setValue(<span class="string">"Bearer \\(token)"</span>, forHTTPHeaderField: <span class="string">"Authorization"</span>)\nURLSession.shared.dataTask(with: request) { data, response, error in\n    if let data = data {\n        <span class="keyword">let</span> result = <span class="keyword">try</span>? JSONSerialization.jsonObject(with: data)\n        print(<span class="string">"Données reçues:"</span>, result ?? <span class="string">"null"</span>)\n    }\n}.resume()`;
            break;
        case 'csharp':
            code = `<span class="comment">// Récupérer des données</span>\nusing (var client = new HttpClient())\n{\n    client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue(<span class="string">"Bearer"</span>, <span class="string">token</span>);\n    var response = await client.GetAsync(<span class="string">"https://api.jolt-framework.org/v1/students"</span>);\n    var data = await response.Content.ReadAsStringAsync();\n    Console.WriteLine(<span class="string">"Données reçues:"</span>, data);\n}`;
            break;
        case 'java':
            code = `<span class="comment">// Récupérer des données</span>\nimport java.net.HttpURLConnection;\nimport java.net.URL;\nURL url = new URL(<span class="string">"https://api.jolt-framework.org/v1/students"</span>);\nHttpURLConnection conn = (HttpURLConnection) url.openConnection();\nconn.setRequestProperty(<span class="string">"Authorization"</span>, <span class="string">"Bearer "</span> + token);\nconn.connect();\nString data = new java.util.Scanner(conn.getInputStream()).nextLine();\nSystem.out.println(<span class="string">"Données reçues:"</span> + data);`;
            break;
    }
    codeElement.innerHTML = code;
}

document.addEventListener('DOMContentLoaded', function () {
    const selectElement = document.getElementById('language-switch');
    selectElement.addEventListener('change', switchLanguage);

    switchLanguage();
});
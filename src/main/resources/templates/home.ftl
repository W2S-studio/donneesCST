<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DummyJSON - Home</title>
    <script nonce="${nonce()}" src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col">
    <header class="bg-blue-600 text-white py-4">
        <div class="container mx-auto px-4 flex justify-between items-center">
            <h1 class="text-2xl font-bold">DummyJSON</h1>
            <nav>
                <a href="/login" class="px-4 py-2 hover:bg-blue-700 rounded">Login</a>
                <a href="/register" class="px-4 py-2 hover:bg-blue-700 rounded">Register</a>
            </nav>
        </div>
    </header>
    <main class="container mx-auto px-4 py-8 flex-grow">
        <section class="text-center">
            <h2 class="text-4xl font-bold mb-4">Welcome to DummyJSON</h2>
            <p class="text-lg text-gray-700 mb-6">Your go-to source for mock JSON data for testing and prototyping.</p>
            <div class="flex justify-center space-x-4">
                <a href="/register" class="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700">Get Started</a>
                <a href="#features" class="bg-gray-200 text-gray-800 px-6 py-3 rounded-lg hover:bg-gray-300">Learn More</a>
            </div>
        </section>
        <section id="features" class="mt-12">
            <h3 class="text-2xl font-semibold text-center mb-8">Features</h3>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div class="bg-white p-6 rounded-lg shadow-md">
                    <h4 class="text-xl font-semibold mb-2">Mock Data</h4>
                    <p class="text-gray-600">Access a wide range of mock JSON data for users, products, and more.</p>
                </div>
                <div class="bg-white p-6 rounded-lg shadow-md">
                    <h4 class="text-xl font-semibold mb-2">API Access</h4>
                    <p class="text-gray-600">Easily integrate with our API for seamless data retrieval.</p>
                </div>
                <div class="bg-white p-6 rounded-lg shadow-md">
                    <h4 class="text-xl font-semibold mb-2">Secure Authentication</h4>
                    <p class="text-gray-600">Secure user management with API key support.</p>
                </div>
            </div>
        </section>
    </main>
    <footer class="bg-gray-800 text-white py-4">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; 2025 DummyJSON. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
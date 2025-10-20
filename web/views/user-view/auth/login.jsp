<html>
    <head>
        <title>Register</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.2/dist/tailwind.min.css" rel="stylesheet">
    </head>
    <body class="bg-gray-100 flex justify-center items-center h-screen">
        <div class="bg-white shadow-md rounded p-6 w-96">
            <h1 class="text-xl font-bold mb-4">Register</h1>
            <form action="${pageContext.request.contextPath}/auth/register" method="post">
                <div class="mb-4">
                    <label class="block mb-1 font-semibold">Firebase UID</label>
                    <input type="text" name="firebaseUid" class="w-full border rounded px-2 py-1">
                </div>
                <div class="mb-4">
                    <label class="block mb-1 font-semibold">Role</label>
                    <select name="role" class="w-full border rounded px-2 py-1">
                        <option value="CUSTOMER">Customer</option>
                        <option value="STAFF">Staff</option>
                    </select>
                </div>
                <button type="submit" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">Register</button>
            </form>
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/auth/login" class="text-blue-500">Back to Login</a>
            </div>
        </div>
    </body>
</html>

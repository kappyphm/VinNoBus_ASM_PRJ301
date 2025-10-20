<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.2/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 flex justify-center items-center h-screen">
    <div class="bg-white shadow-md rounded p-6 w-96">
        <h1 class="text-xl font-bold mb-4">Login</h1>
        <form action="${pageContext.request.contextPath}/auth/login" method="post">
            <div class="mb-4">
                <label class="block mb-1 font-semibold">Firebase UID</label>
                <input type="text" name="firebaseUid" class="w-full border rounded px-2 py-1">
            </div>
            <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Login</button>
        </form>
        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/auth/register" class="text-blue-500">Register</a>
        </div>
    </div>
</body>
</html>

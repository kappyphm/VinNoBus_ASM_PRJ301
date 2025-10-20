<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.2/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-6">
    <h1 class="text-2xl font-bold mb-6">Admin Dashboard</h1>
    <div class="grid grid-cols-3 gap-4">
        <a href="${pageContext.request.contextPath}/admin/staffs" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 text-center">Manage Staff</a>
        <a href="${pageContext.request.contextPath}/admin/customers" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600 text-center">Manage Customers</a>
        <a href="${pageContext.request.contextPath}/admin/users" class="bg-yellow-500 text-white px-4 py-2 rounded hover:bg-yellow-600 text-center">Manage Users</a>
        <a href="${pageContext.request.contextPath}/admin/profiles" class="bg-purple-500 text-white px-4 py-2 rounded hover:bg-purple-600 text-center">Manage Profiles</a>
    </div>
</body>
</html>

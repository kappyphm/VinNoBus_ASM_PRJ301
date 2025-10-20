<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>My Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.2/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-6">
    <div class="max-w-md mx-auto bg-white shadow-md rounded p-6">
        <h1 class="text-xl font-bold mb-4">My Profile</h1>
        <form action="${pageContext.request.contextPath}/customer/profile/update" method="post">
            <div class="mb-4">
                <label class="block mb-1 font-semibold">Full Name</label>
                <input type="text" name="fullName" value="${profile.fullName}" class="w-full border rounded px-2 py-1">
            </div>
            <div class="mb-4">
                <label class="block mb-1 font-semibold">Email</label>
                <input type="email" name="email" value="${profile.email}" class="w-full border rounded px-2 py-1">
            </div>
            <div class="mb-4">
                <label class="block mb-1 font-semibold">Phone</label>
                <input type="text" name="phone" value="${profile.phone}" class="w-full border rounded px-2 py-1">
            </div>
            <div class="mb-4">
                <label class="block mb-1 font-semibold">Address</label>
                <input type="text" name="address" value="${profile.address}" class="w-full border rounded px-2 py-1">
            </div>
            <div class="mb-4">
                <label class="block mb-1 font-semibold">Avatar URL</label>
                <input type="text" name="avatarUrl" value="${profile.avatarUrl}" class="w-full border rounded px-2 py-1">
            </div>
            <div class="mb-4">
                <label class="block mb-1 font-semibold">Date of Birth</label>
                <input type="date" name="dateOfBirth" value="${profile.dateOfBirth}" class="w-full border rounded px-2 py-1">
            </div>
            <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Update</button>
        </form>
    </div>
</body>
</html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Create Staff</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.2/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Roboto Mono', monospace; background:#1f2937; color:#e5e7eb; }
        .card { border-radius:5px; box-shadow:0 2px 6px rgba(0,0,0,0.2); background:#374151; padding:20px; max-width:600px; margin:auto; }
        input, select { border-radius:5px; padding:5px; background:#4b5563; color:white; border:1px solid #6b7280; }
        button { border-radius:5px; padding:10px; background:#3b82f6; color:white; width:100%; }
    </style>
</head>
<body>
    <div class="card mt-10">
        <h1 class="text-xl font-bold mb-4">Create New Staff</h1>
        <form action="${pageContext.request.contextPath}/staff/staffs/create" method="post">
            <div class="mb-3">
                <label>Full Name</label>
                <input type="text" name="fullName" class="w-full">
            </div>
            <div class="mb-3">
                <label>Email</label>
                <input type="email" name="email" class="w-full">
            </div>
            <div class="mb-3">
                <label>Phone</label>
                <input type="text" name="phone" class="w-full">
            </div>
            <div class="mb-3">
                <label>Address</label>
                <input type="text" name="address" class="w-full">
            </div>
            <div class="mb-3">
                <label>Avatar URL</label>
                <input type="text" name="avatarUrl" class="w-full">
            </div>
            <div class="mb-3">
                <label>Date of Birth</label>
                <input type="date" name="dateOfBirth" class="w-full">
            </div>
            <div class="mb-3">
                <label>Staff Code</label>
                <input type="text" name="staffCode" class="w-full">
            </div>
            <div class="mb-3">
                <label>Department</label>
                <input type="text" name="department" class="w-full">
            </div>
            <div class="mb-3">
                <label>Position</label>
                <input type="text" name="position" class="w-full">
            </div>
            <button type="submit">Create Staff</button>
        </form>
    </div>
</body>
</html>

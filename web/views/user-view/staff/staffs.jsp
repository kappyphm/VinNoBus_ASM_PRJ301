<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Staff List</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.2/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-6">
    <h1 class="text-xl font-bold mb-4">Staff List</h1>
    <table class="min-w-full bg-white rounded shadow">
        <thead>
            <tr>
                <th class="px-4 py-2 border">Staff Code</th>
                <th class="px-4 py-2 border">Full Name</th>
                <th class="px-4 py-2 border">Department</th>
                <th class="px-4 py-2 border">Position</th>
                <th class="px-4 py-2 border">Active</th>
                <th class="px-4 py-2 border">Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="staff" items="${staffList}">
                <tr>
                    <td class="px-4 py-2 border">${staff.staffCode}</td>
                    <td class="px-4 py-2 border">${staff.fullName}</td>
                    <td class="px-4 py-2 border">${staff.department}</td>
                    <td class="px-4 py-2 border">${staff.position}</td>
                    <td class="px-4 py-2 border">${staff.isActive ? 'Yes' : 'No'}</td>
                    <td class="px-4 py-2 border">
                        <a href="${pageContext.request.contextPath}/staff/staffs/edit?staffId=${staff.staffId}" class="text-blue-500">Edit</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>

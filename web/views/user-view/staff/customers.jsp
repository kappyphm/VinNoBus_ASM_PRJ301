<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Customer List</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.2/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-6">
    <h1 class="text-xl font-bold mb-4">Customer List</h1>
    <table class="min-w-full bg-white rounded shadow">
        <thead>
            <tr>
                <th class="px-4 py-2 border">Customer ID</th>
                <th class="px-4 py-2 border">Full Name</th>
                <th class="px-4 py-2 border">Membership Level</th>
                <th class="px-4 py-2 border">Loyalty Points</th>
                <th class="px-4 py-2 border">Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="customer" items="${customerList}">
                <tr>
                    <td class="px-4 py-2 border">${customer.customerId}</td>
                    <td class="px-4 py-2 border">${customer.fullName}</td>
                    <td class="px-4 py-2 border">${customer.membershipLevel}</td>
                    <td class="px-4 py-2 border">${customer.loyaltyPoints}</td>
                    <td class="px-4 py-2 border">
                        <a href="${pageContext.request.contextPath}/staff/customers/edit?customerId=${customer.customerId}" class="text-blue-500">Edit</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ cá nhân</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { font-family: 'Roboto', sans-serif; }
    </style>
</head>
<body class="bg-neutral-950 text-gray-100 min-h-screen flex flex-col">
    <!-- Navbar -->
    <nav class="bg-neutral-900 shadow-md shadow-neutral-800/40">
        <div class="max-w-7xl mx-auto px-4 py-3 flex justify-between items-center">
            <a href="${pageContext.request.contextPath}/" class="text-xl font-bold text-white">BusService</a>
            <a href="${pageContext.request.contextPath}/logout" class="px-4 py-2 bg-red-600 hover:bg-red-500 rounded-xl shadow-sm transition">
                Đăng xuất
            </a>
        </div>
    </nav>

    <!-- Nội dung hồ sơ -->
    <main class="flex-1 max-w-3xl mx-auto px-6 py-12">
        <h1 class="text-3xl font-semibold mb-8 text-white text-center">Hồ sơ cá nhân</h1>

        <div class="bg-neutral-900 rounded-2xl shadow-md shadow-neutral-800/50 p-8">
            <div class="flex flex-col items-center space-y-6">
                <div class="w-28 h-28 rounded-full bg-gray-700 flex items-center justify-center text-3xl font-bold text-white">
                    <c:choose>
                        <c:when test="${not empty profile.avatarUrl}">
                            <img src="${profile.avatarUrl}" alt="Avatar" class="w-28 h-28 rounded-full object-cover">
                        </c:when>
                        <c:otherwise>
                            <span>${profile.fullName.substring(0,1)}</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="text-center space-y-2">
                    <h2 class="text-2xl font-semibold">${profile.fullName}</h2>
                    <p class="text-gray-400">${profile.email}</p>
                </div>

                <div class="w-full border-t border-gray-700 my-6"></div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 w-full text-gray-300">
                    <div><span class="font-medium text-gray-400">Số điện thoại:</span> ${profile.phone}</div>
                    <div><span class="font-medium text-gray-400">Ngày sinh:</span> <fmt:formatDate value="${profile.dateOfBirth}" pattern="dd/MM/yyyy" /></div>

                    <div class="md:col-span-2"><span class="font-medium text-gray-400">Địa chỉ:</span> ${profile.address}</div>
                </div>
            </div>
        </div>
    </main>

    <footer class="bg-neutral-900 text-gray-500 text-center py-4 text-sm">
        © 2025 BusService. All rights reserved.
    </footer>
</body>
</html>

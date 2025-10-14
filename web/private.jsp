<%-- 
    Document   : private
    Created on : Oct 14, 2025, 7:59:57 AM
    Author     : kappyphm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Cá Nhân</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto Mono', monospace;
        }
    </style>
</head>
<body class="bg-gray-50 text-black">
    <div class="min-h-screen flex flex-col items-center justify-center">
        <div class="w-full max-w-2xl p-8 bg-white rounded-[5px] shadow-sm text-center">
            <h1 class="text-3xl font-bold mb-4">Khu Vực Riêng Tư</h1>
            <p class="text-gray-600 mb-8">Xin chào, [Tên người dùng]! Chỉ những người dùng đã đăng nhập mới thấy được trang này.</p>
            <div class="flex justify-center gap-4">
                <a href="manage-users.jsp" class="px-6 py-2 bg-black text-white rounded-[5px] hover:bg-gray-800 transition-colors">Quản Lý Người Dùng</a>
                <a href="LogoutServlet" class="px-6 py-2 bg-white text-black border border-black rounded-[5px] hover:bg-gray-100 transition-colors">Đăng Xuất</a>
            </div>
        </div>
    </div>
</body>
</html>

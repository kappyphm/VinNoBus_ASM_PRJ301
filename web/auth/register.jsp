<%-- 
    Document   : register
    Created on : Oct 14, 2025, 7:59:44 AM
    Author     : kappyphm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký</title>
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
    <div class="min-h-screen flex items-center justify-center">
        <div class="w-full max-w-sm p-8 bg-white rounded-[5px] shadow-sm">
            <h2 class="text-2xl font-bold text-center mb-6">Tạo Tài Khoản</h2>
            <form action="RegisterServlet" method="post">
                <div class="mb-4">
                    <label for="username" class="block text-sm font-medium text-gray-700 mb-1">Tên đăng nhập</label>
                    <input type="text" id="username" name="username" required class="w-full px-3 py-2 border border-gray-300 rounded-[5px] focus:outline-none focus:ring-1 focus:ring-black">
                </div>
                <div class="mb-4">
                    <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Mật khẩu</label>
                    <input type="password" id="password" name="password" required class="w-full px-3 py-2 border border-gray-300 rounded-[5px] focus:outline-none focus:ring-1 focus:ring-black">
                </div>
                <div class="mb-6">
                    <label for="confirm-password" class="block text-sm font-medium text-gray-700 mb-1">Xác nhận mật khẩu</label>
                    <input type="password" id="confirm-password" name="confirmPassword" required class="w-full px-3 py-2 border border-gray-300 rounded-[5px] focus:outline-none focus:ring-1 focus:ring-black">
                </div>
                <button type="submit" class="w-full bg-black text-white py-2 rounded-[5px] hover:bg-gray-800 transition-colors">Đăng Ký</button>
            </form>
            <p class="text-center text-sm text-gray-600 mt-6">
                Đã có tài khoản? <a href="login.jsp" class="text-black hover:underline">Đăng nhập</a>
            </p>
        </div>
    </div>
</body>
</html>


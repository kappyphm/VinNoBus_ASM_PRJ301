<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giới thiệu dịch vụ xe bus</title>

    <!-- Font Roboto -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>

    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }
    </style>
</head>
<body class="bg-neutral-950 text-gray-100 min-h-screen flex flex-col">
    <!-- Navbar -->
    <nav class="bg-neutral-900 shadow-md shadow-neutral-800/40">
        <div class="max-w-7xl mx-auto px-4 py-3 flex justify-between items-center">
            <div class="flex items-center space-x-8">
                <a href="index.jsp" class="text-xl font-bold text-white hover:text-gray-300 transition">BusService</a>
                <ul class="flex space-x-6">
                    <li><a href="index.jsp" class="hover:text-gray-300 transition">Trang chủ</a></li>
                    <li><a href="muave.jsp" class="hover:text-gray-300 transition">Mua vé</a></li>
                    <li><a href="tracuu.jsp" class="hover:text-gray-300 transition">Tra cứu</a></li>
                    <li><a href="gioithieu.jsp" class="text-gray-300 font-medium">Giới thiệu</a></li>
                </ul>
            </div>

            <div>
                <c:choose>
                    <c:when test="${not empty sessionScope.user_id}">
                        <a href="${ctx}/user/profile" class="px-4 py-2 bg-gray-700 hover:bg-gray-600 rounded-xl shadow-sm transition">
                            Trang cá nhân
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${ctx}/auth/login" class="px-4 py-2 bg-blue-600 hover:bg-blue-500 rounded-xl shadow-sm transition">
                            Đăng nhập
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </nav>

    <!-- Nội dung chính -->
    <main class="flex-1 max-w-4xl mx-auto px-6 py-12">
        <h1 class="text-3xl font-semibold mb-6 text-white">Giới thiệu dịch vụ xe bus thông minh</h1>
        <div class="space-y-5 text-gray-300 leading-relaxed">
            <p>Dịch vụ xe bus thông minh được phát triển nhằm mang lại trải nghiệm di chuyển tiện lợi, nhanh chóng và an toàn cho mọi người dân. 
            Hệ thống được tối ưu hóa để giúp người dùng dễ dàng tra cứu, đặt vé và theo dõi lịch trình xe bus theo thời gian thực.</p>

            <p>Với giao diện thân thiện, dễ sử dụng, người dùng có thể mua vé online, kiểm tra thông tin các tuyến, cũng như nhận thông báo về thay đổi lịch trình 
            ngay trên điện thoại hoặc máy tính.</p>

            <p>Chúng tôi hướng tới việc xây dựng một mạng lưới giao thông công cộng hiện đại, thân thiện với môi trường, 
            góp phần giảm thiểu ùn tắc và ô nhiễm không khí tại các đô thị lớn.</p>

            <p>Hãy cùng chúng tôi trải nghiệm sự tiện nghi của việc di chuyển bằng xe bus thông minh – an toàn, tiết kiệm và văn minh!</p>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-neutral-900 text-gray-400 text-center py-4 text-sm">
        © 2025 BusService. All rights reserved.
    </footer>
</body>
</html>

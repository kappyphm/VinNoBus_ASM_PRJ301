<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thêm trạm mới</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Font đẹp, hỗ trợ tiếng Việt -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Inter', sans-serif;
            }
            @keyframes fadeIn {
                0% {
                    opacity: 0;
                    transform: scale(0.95);
                }
                100% {
                    opacity: 1;
                    transform: scale(1);
                }
            }
            .animate-fadeIn {
                animation: fadeIn 0.7s ease-out forwards;
            }
        </style>
    </head>

    <body class="bg-gradient-to-br from-blue-200 via-blue-100 to-blue-300 font-sans min-h-screen flex items-center justify-center p-6">

        <!-- Khung chính -->
        <div class="bg-white shadow-2xl rounded-2xl w-full max-w-md p-8 border-t-4 border-blue-500 animate-fadeIn">
            <h2 class="text-3xl font-bold mb-6 text-center text-blue-700">Thêm trạm mới</h2>

            <% if (request.getAttribute("error") != null) { %>
            <p class="text-red-600 font-semibold mb-4 text-center animate-pulse">
                <%= request.getAttribute("error") %>
            </p>
            <% } %>

            <form action="StationServlet" method="post" class="space-y-5">
                <input type="hidden" name="action" value="create">

                <!-- Tên trạm -->
                <div class="bg-blue-50 border border-blue-200 rounded-lg px-4 py-3 hover:shadow-md transition">
                    <label class="block text-blue-800 font-medium mb-1">Tên trạm</label>
                    <input type="text" name="stationName" required
                           class="w-full border border-gray-300 rounded-md px-3 py-2 focus:ring-2 focus:ring-blue-400 focus:outline-none transition">
                </div>

                <!-- Vị trí -->
                <div class="bg-blue-50 border border-blue-200 rounded-lg px-4 py-3 hover:shadow-md transition">
                    <label class="block text-blue-800 font-medium mb-1">Vị trí</label>
                    <input type="text" name="location" required
                           class="w-full border border-gray-300 rounded-md px-3 py-2 focus:ring-2 focus:ring-blue-400 focus:outline-none transition">
                </div>

                <!-- Giờ mở cửa -->
                <div class="bg-blue-50 border border-blue-200 rounded-lg px-4 py-3 hover:shadow-md transition">
                    <label class="block text-blue-800 font-medium mb-1">Giờ mở cửa</label>
                    <input type="time" name="openTime"
                           class="w-full border border-gray-300 rounded-md px-3 py-2 focus:ring-2 focus:ring-blue-400 focus:outline-none transition">
                </div>

                <!-- Giờ đóng cửa -->
                <div class="bg-blue-50 border border-blue-200 rounded-lg px-4 py-3 hover:shadow-md transition">
                    <label class="block text-blue-800 font-medium mb-1">Giờ đóng cửa</label>
                    <input type="time" name="closeTime"
                           class="w-full border border-gray-300 rounded-md px-3 py-2 focus:ring-2 focus:ring-blue-400 focus:outline-none transition">
                </div>

                <!-- Nút hành động -->
                <div class="flex justify-between items-center mt-6">
                    <button type="submit"
                            class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-full shadow-lg hover:shadow-xl transform hover:scale-105 transition duration-300">
                        Thêm trạm
                    </button>
                    <a href="StationServlet?action=list"
                       class="text-blue-600 hover:text-blue-800 hover:underline transition-colors duration-300">
                        Hủy
                    </a>
                </div>
            </form>
        </div>

    </body>
</html>

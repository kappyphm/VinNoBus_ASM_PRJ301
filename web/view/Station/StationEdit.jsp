<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Cập nhật trạm</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Inter', sans-serif;
            }
            @keyframes fadeIn {
                0% {
                    opacity: 0;
                    transform: translateY(15px);
                }
                100% {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .animate-fadeIn {
                animation: fadeIn 0.6s ease-out forwards;
            }
        </style>
    </head>

    <body class="bg-gradient-to-br from-blue-100 via-indigo-100 to-blue-200 min-h-screen flex items-center justify-center p-6">

        <div class="bg-white shadow-2xl rounded-2xl w-full max-w-md p-8 border-t-4 border-blue-500 animate-fadeIn">
            <h2 class="text-3xl font-bold mb-6 text-center text-blue-700">Cập nhật thông tin trạm</h2>

            <!-- Hiển thị lỗi nếu có -->
            <c:if test="${not empty error}">
                <p class="text-red-600 font-semibold mb-4 text-center animate-pulse">${error}</p>
            </c:if>

            <!-- Nếu có dữ liệu trạm -->
            <c:choose>
                <c:when test="${not empty station}">
                    <form action="StationServlet" method="post" class="space-y-5">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="stationId" value="${station.stationId}">

                        <!-- Tên trạm -->
                        <div class="bg-blue-50 border border-blue-200 rounded-lg px-4 py-3 hover:shadow-md transition">
                            <label class="block text-blue-800 font-medium mb-1">Tên trạm</label>
                            <input type="text" name="stationName" value="${station.stationName}" required
                                   class="w-full border border-gray-300 rounded-md px-3 py-2 focus:ring-2 focus:ring-blue-400 focus:outline-none transition">
                        </div>

                        <!-- Vị trí -->
                        <div class="bg-blue-50 border border-blue-200 rounded-lg px-4 py-3 hover:shadow-md transition">
                            <label class="block text-blue-800 font-medium mb-1">Vị trí</label>
                            <input type="text" name="location" value="${station.location}" required
                                   class="w-full border border-gray-300 rounded-md px-3 py-2 focus:ring-2 focus:ring-blue-400 focus:outline-none transition">
                        </div>

                        <!-- Nút hành động -->
                        <div class="flex justify-between items-center mt-6">
                            <button type="submit"
                                    class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-full shadow-lg hover:shadow-xl transform hover:scale-105 transition duration-300">
                                Cập nhật
                            </button>
                            <a href="StationServlet?action=list"
                               class="text-blue-600 hover:text-blue-800 hover:underline transition-colors duration-300">
                                Hủy
                            </a>
                        </div>
                    </form>
                </c:when>

                <c:otherwise>
                    <p class="text-red-600 font-semibold text-center mb-4">Không có dữ liệu để chỉnh sửa.</p>
                    <div class="text-center">
                        <a href="StationServlet?action=list"
                           class="text-blue-600 hover:text-blue-800 underline transition-colors duration-300">
                            ← Quay lại
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="vi">
    <head>
        <title>✏️ Chỉnh Sửa Tuyến</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="min-h-screen flex items-center justify-center bg-gradient-to-br from-blue-100 via-indigo-200 to-blue-300 p-6">

        <div class="bg-white bg-opacity-90 backdrop-blur-md shadow-2xl rounded-2xl w-full max-w-lg p-8 animate-fadeSlideUp">
            <h2 class="text-2xl font-bold text-center text-indigo-700 mb-6">✏️ Cập Nhật Thông Tin Tuyến</h2>

            <!-- Thông báo thành công -->
            <c:if test="${not empty message}">
                <div class="text-green-700 bg-green-100 border border-green-400 p-3 rounded-lg text-center mb-4">
                    ${message}
                </div>
            </c:if>

            <!-- Thông báo lỗi -->
            <c:if test="${not empty errorMessage}">
                <div class="text-red-700 bg-red-100 border border-red-400 p-3 rounded-lg text-center mb-4">
                    ${errorMessage}
                </div>
            </c:if>

            <form action="RouteServlet?action=update" method="post" class="space-y-5">
                <input type="hidden" name="routeId" value="${route.routeId}"/>

                <div class="bg-gradient-to-r from-indigo-50 to-blue-50 p-4 rounded-xl shadow-inner">
                    <label class="block font-semibold text-gray-700 mb-1">Tên tuyến</label>
                    <input type="text" name="routeName" value="${route.routeName}" 
                           class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-400">
                </div>

                <div class="bg-gradient-to-r from-indigo-50 to-blue-50 p-4 rounded-xl shadow-inner">
                    <label class="block font-semibold text-gray-700 mb-1">Loại tuyến</label>
                    <select name="type" 
                            class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-400">
                        <option value="CIRCULAR" ${route.type == 'CIRCULAR' ? 'selected' : ''}>CIRCULAR</option>
                        <option value="ROUND_TRIP" ${route.type == 'ROUND_TRIP' ? 'selected' : ''}>ROUND_TRIP</option>
                    </select>
                </div>

                <div class="bg-gradient-to-r from-indigo-50 to-blue-50 p-4 rounded-xl shadow-inner">
                    <label class="block font-semibold text-gray-700 mb-1">Tần suất (chuyến/ngày)</label>
                    <input type="number" name="frequency" min="1" value="${route.frequency}" 
                           class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-400">
                </div>

                <div class="flex justify-between mt-6">
                    <a href="RouteServlet?action=list" 
                       class="px-5 py-2 rounded-lg bg-gradient-to-r from-gray-200 to-gray-300 hover:from-gray-300 hover:to-gray-400 text-gray-700 font-medium shadow transition">
                        ⬅ Quay lại
                    </a>

                    <button type="submit" 
                            class="px-6 py-2 rounded-lg bg-gradient-to-r from-indigo-500 to-blue-500 hover:from-indigo-600 hover:to-blue-600 text-white font-semibold shadow-lg transition">
                        💾 Cập Nhật
                    </button>
                </div>
            </form>
        </div>

        <style>
            @keyframes fadeSlideUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .animate-fadeSlideUp {
                animation: fadeSlideUp 0.6s ease-out;
            }
        </style>

    </body>
</html>

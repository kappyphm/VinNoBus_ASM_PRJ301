<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Gán Trạm Cho Tuyến</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>

    <body class="min-h-screen flex justify-center items-center
          bg-gradient-to-br from-blue-100 via-purple-100 to-pink-100
          font-[Segoe_UI] text-gray-800">

        <div class="w-full max-w-5xl bg-white/80 backdrop-blur-md rounded-2xl shadow-lg p-8 border border-white/50 animate-fadeSlideUp">

            <h2 class="text-3xl font-bold text-center bg-gradient-to-r from-blue-600 via-purple-600 to-pink-600
                text-transparent bg-clip-text mb-6 drop-shadow-sm">
                🚌 Gán Trạm Cho Tuyến: <span class="text-gray-800">${route.routeName}</span>
            </h2>

            <!-- ✅ Thông báo -->
            <c:if test="${not empty sessionScope.message}">
                <div class="bg-green-100 text-green-800 border-l-4 border-green-500 p-4 mb-5 rounded-lg shadow-sm flex items-center">
                    <span class="text-xl mr-2">✅</span>
                    <span>${sessionScope.message}</span>
                </div>
                <c:remove var="message" scope="session"/>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="bg-red-100 text-red-800 border-l-4 border-red-500 p-4 mb-5 rounded-lg shadow-sm flex items-center">
                    <span class="text-xl mr-2">⚠️</span>
                    <span>${errorMessage}</span>
                </div>
            </c:if>

            <!-- 🧭 Form gán trạm -->
            <form action="RouteServlet?action=saveAssignedStations" method="post" class="space-y-6">
                <input type="hidden" name="routeId" value="${route.routeId}" />

                <div class="overflow-hidden rounded-xl shadow-md border border-gray-300">
                    <table class="min-w-full text-sm text-gray-800 border-collapse">
                        <thead>
                            <tr class="bg-gradient-to-r from-blue-500 via-purple-500 to-pink-500 text-white text-left">
                                <th class="px-4 py-3 border border-gray-300">Chọn</th>
                                <th class="px-4 py-3 border border-gray-300">Tên Trạm</th>
                                <th class="px-4 py-3 border border-gray-300">Thứ Tự</th>
                                <th class="px-4 py-3 border border-gray-300">Thời Gian Dự Kiến (phút)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="station" items="${allStations}">
                                <tr class="odd:bg-gradient-to-r odd:from-blue-50 odd:to-purple-50
                                    even:bg-gradient-to-r even:from-pink-50 even:to-indigo-50
                                    hover:bg-gradient-to-r hover:from-blue-100 hover:to-pink-100
                                    transition-all duration-300 border-t border-gray-300">
                                    <td class="px-4 py-2 border border-gray-300 text-center">
                                        <input type="checkbox" name="stationIds" value="${station.stationId}" class="w-5 h-5 accent-blue-600" />
                                    </td>
                                    <td class="px-4 py-2 border border-gray-300">${station.stationName}</td>
                                    <td class="px-4 py-2 border border-gray-300">
                                        <input type="number" name="stationOrder" min="1"
                                               class="w-24 p-1 border border-gray-300 rounded-md text-center focus:ring-2 focus:ring-blue-400"/>
                                    </td>
                                    <td class="px-4 py-2 border border-gray-300">
                                        <input type="number" name="estimatedTime" min="0"
                                               class="w-28 p-1 border border-gray-300 rounded-md text-center focus:ring-2 focus:ring-pink-400"/>
                                    </td>

                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Nút hành động -->
                <div class="flex justify-center gap-4 mt-6">
                    <a href="RouteServlet?action=list"
                       class="px-5 py-2 rounded-lg bg-gradient-to-r from-gray-500 to-gray-600 text-white shadow-md hover:opacity-90 transition">
                        ⬅ Quay lại
                    </a>
                    <button type="submit"
                            class="px-6 py-2 rounded-lg bg-gradient-to-r from-blue-500 via-purple-500 to-pink-500 text-white shadow-md hover:opacity-90 transition">
                        💾 Lưu Danh Sách Trạm
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

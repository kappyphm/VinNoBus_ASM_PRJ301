<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Gán Trạm cho Tuyến</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-50 min-h-screen p-8">

        <div class="max-w-6xl mx-auto bg-white p-8 rounded-2xl shadow-xl animate-fadeIn">
            <h2 class="text-3xl font-bold mb-6 text-gray-800">
                Gán trạm cho tuyến: <span class="text-blue-600">${route.routeName} (${route.type})</span>
            </h2>

            <c:if test="${not empty errorMessage}">
                <div class="bg-red-100 text-red-700 p-4 rounded-lg mb-6 shadow-inner animate-pulse">
                    ${errorMessage}
                </div>
            </c:if>

            <form action="RouteServlet" method="post" class="space-y-6">
                <input type="hidden" name="action" value="saveAssignedStations">
                <input type="hidden" name="routeId" value="${route.routeId}">

                <div class="overflow-x-auto rounded-xl shadow-lg border border-gray-200">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gradient-to-r from-blue-500 via-purple-500 to-pink-500 text-white">
                            <tr>
                                <th class="px-4 py-3 text-left">Chọn</th>
                                <th class="px-4 py-3 text-left">Tên trạm</th>
                                <th class="px-4 py-3 text-left">Thứ tự</th>
                                <th class="px-4 py-3 text-left">Thời gian dự kiến (phút)</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <c:forEach var="station" items="${allStations}" varStatus="status">
                                <tr class="transition-colors duration-300 hover:bg-blue-50">
                                    <td class="px-4 py-2">
                                        <input type="checkbox" name="stationIds" value="${station.stationId}" 
                                               class="w-6 h-6 text-blue-600 accent-blue-500 hover:scale-110 transition-transform duration-200"
                                               data-index="${status.index}">
                                        <input type="hidden" name="index_of_${station.stationId}" value="${status.index}">
                                    </td>
                                    <td class="px-4 py-2 font-medium text-gray-700">${station.stationName}</td>
                                    <td class="px-4 py-2">
                                        <input type="number" name="stationOrder_${status.index}" min="1"
                                               class="w-20 border border-gray-300 rounded-lg px-3 py-1 text-gray-700
                                               focus:outline-none focus:ring-2 focus:ring-blue-400 transition duration-200">
                                    </td>
                                    <td class="px-4 py-2">
                                        <input type="number" name="estimatedTime_${status.index}" min="0"
                                               class="w-24 border border-gray-300 rounded-lg px-3 py-1 text-gray-700
                                               focus:outline-none focus:ring-2 focus:ring-blue-400 transition duration-200">
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="flex items-center gap-4">
                    <button type="submit" 
                            class="bg-blue-600 text-white px-6 py-3 rounded-xl font-semibold shadow-lg hover:bg-blue-700
                            hover:scale-105 transition-transform duration-200">
                        Lưu danh sách trạm
                    </button>
                    <a href="RouteServlet?action=details&id=${route.routeId}" 
                       class="text-gray-600 hover:text-blue-600 hover:underline transition-colors duration-200">
                        Hủy / Quay lại chi tiết tuyến
                    </a>
                </div>
            </form>
        </div>

        <style>
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .animate-fadeIn {
                animation: fadeIn 0.5s ease-out forwards;
            }
        </style>

    </body>
</html>

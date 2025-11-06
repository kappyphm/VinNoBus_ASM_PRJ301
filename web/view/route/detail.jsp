<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết tuyến đường</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>

    <body class="min-h-screen flex justify-center items-center
          bg-gradient-to-br from-blue-100 via-purple-100 to-pink-100
          font-[Segoe_UI] text-gray-800">

        <div class="w-full max-w-5xl bg-white/80 backdrop-blur-md rounded-2xl shadow-lg p-8 border border-white/50 animate-fadeSlideUp">

            <h2 class="text-3xl font-bold text-center bg-gradient-to-r from-blue-600 via-purple-600 to-pink-600
                text-transparent bg-clip-text mb-6 drop-shadow-sm">
                ✨ Chi tiết tuyến đường
            </h2>

            <!-- Thông tin tuyến -->
            <div class="overflow-hidden rounded-xl shadow-md border border-gray-300">
                <table class="min-w-full border-collapse text-sm text-gray-800">
                    <tbody>
                        <tr class="bg-gradient-to-r from-blue-50 to-purple-50 border-b border-gray-300">
                            <td class="font-semibold p-3 w-1/3 border-r border-gray-300">Mã tuyến đường</td>
                            <td class="p-3"><c:out value="${route.routeId}" /></td>
                        </tr>
                        <tr class="bg-gradient-to-r from-purple-50 to-pink-50 border-b border-gray-300">
                            <td class="font-semibold p-3 border-r border-gray-300">Tên tuyến đường</td>
                            <td class="p-3"><c:out value="${route.routeName}" /></td>
                        </tr>
                        <tr class="bg-gradient-to-r from-blue-50 to-cyan-50 border-b border-gray-300">
                            <td class="font-semibold p-3 border-r border-gray-300">Loại tuyến</td>
                            <td class="p-3"><c:out value="${route.type}" /></td>
                        </tr>
                        <tr class="bg-gradient-to-r from-indigo-50 to-blue-50 border-b border-gray-300">
                            <td class="font-semibold p-3 border-r border-gray-300">Tần suất</td>
                            <td class="p-3"><c:out value="${route.frequency}" /> chuyến/ngày</td>
                        </tr>
                        <tr class="bg-gradient-to-r from-pink-50 to-purple-50">
                            <td class="font-semibold p-3 border-r border-gray-300">Tổng thời gian dự kiến</td>
                            <td class="p-3"><c:out value="${route.estimatedTime}" /> phút</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Danh sách trạm -->
            <h3 class="text-xl font-semibold mt-8 mb-3 text-gray-800">
                🚌 Danh sách trạm đi qua
            </h3>

            <c:choose>
                <c:when test="${not empty route.stations}">
                    <div class="overflow-hidden rounded-xl shadow-md border border-gray-300">
                        <table class="min-w-full border-collapse text-sm text-gray-800">
                            <thead>
                                <tr class="bg-gradient-to-r from-blue-500 via-purple-500 to-pink-500 text-white text-left">
                                    <th class="px-4 py-3 border border-gray-300">Thứ tự</th>
                                    <th class="px-4 py-3 border border-gray-300">Mã trạm</th>
                                    <th class="px-4 py-3 border border-gray-300">Tên trạm</th>
                                    <th class="px-4 py-3 border border-gray-300">Vị trí</th>
                                    <th class="px-4 py-3 border border-gray-300">Thời gian dự kiến (phút)</th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:forEach var="s" items="${route.stations}">
                                    <tr class="odd:bg-gradient-to-r odd:from-blue-50 odd:to-purple-50
                                        even:bg-gradient-to-r even:from-pink-50 even:to-indigo-50
                                        hover:bg-gradient-to-r hover:from-blue-100 hover:to-pink-100
                                        transition-all duration-300 border-t border-gray-300">

                                        <td class="px-4 py-2 border border-gray-300 text-center">
                                            <c:out value="${s.stationOrder}" />
                                        </td>

                                        <td class="px-4 py-2 border border-gray-300">
                                            <c:out value="${s.stationId}" />
                                        </td>

                                        <td class="px-4 py-2 border border-gray-300">
                                            <c:out value="${s.stationName}" />
                                        </td>

                                        <td class="px-4 py-2 border border-gray-300">
                                            <c:out value="${s.location}" />
                                        </td>

                                        <td class="px-4 py-2 border border-gray-300 text-center">
                                            <c:out value="${s.estimatedTime}" /> phút
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>

                <c:otherwise>
                    <p class="text-center text-gray-600 italic mt-3">
                        Không có trạm nào thuộc tuyến này.
                    </p>
                </c:otherwise>
            </c:choose>


            <!-- Nút hành động -->
            <div class="flex justify-center gap-4 mt-8">
                <a href="RouteServlet?action=list"
                   class="px-5 py-2 rounded-lg bg-gradient-to-r from-gray-500 to-gray-600 text-white shadow-md hover:opacity-90 transition">
                    ⬅ Quay lại
                </a>

                <a href="RouteServlet?action=edit&id=${route.routeId}"
                   class="px-5 py-2 rounded-lg bg-gradient-to-r from-yellow-400 to-amber-500 text-black shadow-md hover:opacity-90 transition">
                    ✏ Sửa
                </a>

                <a href="RouteServlet?action=delete&id=${route.routeId}"
                   onclick="return confirm('Bạn có chắc muốn xóa tuyến đường này không?');"
                   class="px-5 py-2 rounded-lg bg-gradient-to-r from-red-500 to-pink-500 text-white shadow-md hover:opacity-90 transition">
                    🗑 Xóa
                </a>
            </div>
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

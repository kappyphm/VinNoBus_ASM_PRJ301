<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết trạm</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Inter', sans-serif;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(15px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .animate-fadeIn {
                animation: fadeIn 0.7s ease-out forwards;
            }
        </style>
    </head>
    <body class="bg-gradient-to-br from-blue-100 via-indigo-100 to-pink-100 min-h-screen flex items-center justify-center p-6">

        <div class="bg-white shadow-2xl rounded-2xl w-full max-w-lg p-8 animate-fadeIn">
            <h1 class="text-3xl font-bold text-center text-gray-800 mb-6">Chi tiết trạm</h1>

            <!-- Hiển thị lỗi nếu có -->
            <c:if test="${not empty error}">
                <p class="text-red-600 font-semibold text-center mb-4">${error}</p>
                <div class="text-center">
                    <a href="StationServlet?action=list"
                       class="inline-block mt-2 text-blue-600 hover:text-blue-800 transition-colors duration-300 underline">
                        ← Quay lại danh sách
                    </a>
                </div>
            </c:if>

            <!-- Hiển thị thông tin trạm nếu có -->
            <c:if test="${not empty station}">
                <div class="divide-y divide-gray-200">
                    <div class="py-2 flex justify-between">
                        <span class="font-semibold text-gray-700">Mã trạm:</span>
                        <span class="text-gray-800">${station.stationId}</span>
                    </div>
                    <div class="py-2 flex justify-between">
                        <span class="font-semibold text-gray-700">Tên trạm:</span>
                        <span class="text-gray-800">${station.stationName}</span>
                    </div>
                    <div class="py-2 flex justify-between">
                        <span class="font-semibold text-gray-700">Vị trí:</span>
                        <span class="text-gray-800">${station.location}</span>
                    </div>
                    <div class="py-2 flex justify-between items-start">
                        <span class="font-semibold text-gray-700">Tuyến đi qua:</span>
                        <span class="text-gray-800 text-right">
                            <c:choose>
                                <c:when test="${not empty station.routeNames}">
                                    <c:forEach var="name" items="${station.routeNames}" varStatus="loop">
                                        ${name}<c:if test="${!loop.last}">, </c:if>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>Không có</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>

                <div class="mt-8 text-center">
                    <a href="StationServlet?action=list"
                       class="inline-block bg-blue-500 text-white font-medium px-5 py-2 rounded-lg shadow hover:bg-blue-600 transition-all duration-300">
                        ← Quay lại danh sách
                    </a>
                </div>
            </c:if>

            <!-- Thông báo nếu không có trạm -->
            <c:if test="${empty station and empty error}">
                <p class="text-red-600 font-semibold text-center mb-4">Không tìm thấy thông tin trạm.</p>
                <div class="text-center">
                    <a href="StationServlet?action=list"
                       class="text-blue-600 hover:text-blue-800 underline transition-colors duration-300">
                        ← Quay lại danh sách
                    </a>
                </div>
            </c:if>
        </div>

    </body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Chi tiết trạm</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gradient-to-br from-blue-100 via-purple-100 to-pink-100 font-sans min-h-screen flex items-center justify-center p-6">

        <div class="bg-white shadow-2xl rounded-xl w-full max-w-md p-8 transform transition-all duration-700 scale-95 opacity-0 animate-fadeIn">
            <h2 class="text-3xl font-bold mb-6 text-center text-gray-800">Chi tiết trạm</h2>

            <!-- Hiển thị lỗi nếu có -->
            <c:if test="${not empty error}">
                <p class="text-red-600 font-semibold mb-4 text-center animate-pulse">${error}</p>
                <div class="text-center">
                    <a href="StationServlet?action=list" 
                       class="text-blue-500 hover:underline">Quay lại danh sách</a>
                </div>
            </c:if>

            <!-- Hiển thị thông tin trạm nếu có -->
            <c:if test="${not empty station}">
                <div class="space-y-3">
                    <p><span class="font-semibold text-gray-700">ID:</span> <span class="text-gray-800">${station.stationId}</span></p>
                    <p><span class="font-semibold text-gray-700">Tên trạm:</span> <span class="text-gray-800">${station.stationName}</span></p>
                    <p><span class="font-semibold text-gray-700">Vị trí:</span> <span class="text-gray-800">${station.location}</span></p>
                    <p><span class="font-semibold text-gray-700">Giờ mở cửa:</span> <span class="text-gray-800">${station.openTime}</span></p>
                    <p><span class="font-semibold text-gray-700">Giờ đóng cửa:</span> <span class="text-gray-800">${station.closeTime}</span></p>
                    <p><span class="font-semibold text-gray-700">Tuyến đi qua:</span> 
                        <span class="text-gray-800">
                            <c:choose>
                                <c:when test="${not empty station.routeNames}">
                                    ${fn:join(station.routeNames, ', ')}
                                </c:when>
                                <c:otherwise>
                                    Không có
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </p>
                </div>
                <div class="mt-6 text-center">
                    <a href="StationServlet?action=list"
                       class="text-blue-500 hover:text-blue-700 hover:underline transition-colors duration-300">← Quay lại</a>
                </div>
            </c:if>

            <!-- Thông báo nếu không có trạm -->
            <c:if test="${empty station and empty error}">
                <p class="text-red-600 font-semibold mb-4 text-center animate-pulse">Không tìm thấy thông tin trạm.</p>
                <div class="text-center">
                    <a href="StationServlet?action=list" 
                       class="text-blue-500 hover:underline">Quay lại danh sách</a>
                </div>
            </c:if>

        </div>

        <!-- Custom animation -->
        <style>
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
                animation: fadeIn 0.8s ease-out forwards;
            }
        </style>
    </body>
</html>

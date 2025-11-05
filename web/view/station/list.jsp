<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách trạm</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
              integrity="sha512-p1M+Pq+3tHvJ5cWy7eohF0uUE9uoF7EN0uXY6x2iVQH+MsvZ9A4uwX9xX7d+4+Nq4U9lBLc1oxgvdYgH3Xv1sA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
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
            .fade-up {
                animation: fadeSlideUp 0.6s ease;
            }
        </style>
    </head>
    <body class="font-sans bg-gray-100 min-h-screen flex flex-col">

        <!-- Header cách đều trên -->
        <jsp:include page="/header.jsp" />

        <!-- Container chính -->
        <div class="flex-1 container mx-auto my-12 bg-white rounded-2xl shadow-2xl p-10 max-w-7xl">
            <h2 class="text-center text-3xl font-bold text-gray-800 mb-10 relative">
                Danh sách trạm xe buýt
                <span class="block w-32 h-1 bg-gradient-to-r from-blue-500 to-green-400 mx-auto mt-3 rounded-full shadow-md"></span>
            </h2>

            <c:if test="${not empty error}">
                <div class="bg-red-100 text-red-700 border-l-4 border-red-500 p-4 mb-4 rounded-md fade-up text-center shadow">
                    ${error}
                </div>
            </c:if>

            <c:if test="${not empty message}">
                <div class="bg-green-100 text-green-700 border-l-4 border-green-500 p-4 mb-4 rounded-md fade-up text-center shadow">
                    ${message}
                </div>
            </c:if>

            <!-- Toolbar -->
            <div class="flex flex-wrap justify-between items-center mb-6 fade-up">

                <!-- Nút Thêm trạm mới lên bên trái -->
                <a href="StationServlet?action=new"
                   class="inline-flex items-center bg-gradient-to-r from-blue-500 to-green-400 text-white px-5 py-2 rounded-lg shadow-md text-sm font-medium hover:-translate-y-1 hover:shadow-lg hover:brightness-110 transition-all duration-200">
                    <span class="mr-2">+</span> Thêm trạm mới
                </a>

                <!-- Form tìm kiếm ra bên phải -->
                <form method="get" class="flex items-center gap-2">
                    <input 
                        type="text" 
                        name="search" 
                        value="${param.search}" 
                        placeholder="Tìm kiếm trạm..." 
                        class="border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
                        />
                    <button type="submit" 
                            class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition-all duration-200">
                        Tìm
                    </button>
                </form>
            </div>

            <!-- Table -->
            <div class="overflow-x-auto rounded-xl border border-gray-200 shadow-lg fade-up">
                <table class="w-full border-collapse text-center">
                    <thead class="border border-gray-300">
                        <tr class="bg-gradient-to-r from-blue-600 to-green-500 text-white">
                            <th class="py-3 px-4 font-semibold border border-gray-300">ID</th>
                            <th class="py-3 px-4 font-semibold border border-gray-300">Tên trạm</th>
                            <th class="py-3 px-4 font-semibold border border-gray-300">Vị trí</th>
                            <th class="py-3 px-4 font-semibold border border-gray-300">Tuyến đi qua</th>
                            <th class="py-3 px-4 font-semibold border border-gray-300">Thao tác</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:choose>
                            <c:when test="${not empty stations}">
                                <c:forEach var="s" items="${stations}">
                                    <tr class="border border-gray-300 even:bg-blue-50 hover:bg-blue-100 hover:scale-[1.01] hover:shadow-md focus-within:scale-[1.01] focus-within:shadow-md transition-all duration-200 cursor-pointer">
                                        <td class="py-3 px-2 border border-gray-300 text-center" style="width:6%;">${s.stationId}</td>
                                        <td class="py-3 px-2 border border-gray-300 text-center min-w-[120px]"><i class="fa fa-bus text-blue-500 mr-1"></i>${s.stationName}</td>
                                        <td class="py-3 px-2 border border-gray-300 text-center min-w-[120px]">${s.location}</td>
                                        <td class="py-3 px-2 border border-gray-300 text-center min-w-[200px]">
                                            <c:if test="${not empty s.routeNames}">
                                                <c:forEach var="r" items="${s.routeNames}" varStatus="loop">
                                                    ${r}<c:if test="${!loop.last}">, </c:if>
                                                </c:forEach>
                                            </c:if>
                                        </td>
                                        <td class="py-3 px-2 border border-gray-300 text-center">
                                            <div class="flex justify-center gap-2">
                                                <a href="StationServlet?action=view&id=${s.stationId}"
                                                   class="bg-blue-500 text-white px-3 py-1 rounded-md text-sm hover:bg-blue-600 hover:shadow-md transition-all duration-150">
                                                    <i class="fa fa-eye"></i> Xem
                                                </a>
                                                <a href="StationServlet?action=edit&id=${s.stationId}"
                                                   class="bg-yellow-500 text-white px-3 py-1 rounded-md text-sm hover:bg-yellow-600 hover:shadow-md transition-all duration-150">
                                                    <i class="fa fa-pen"></i> Sửa
                                                </a>
                                                <a href="StationServlet?action=delete&id=${s.stationId}"
                                                   onclick="return confirm('Xóa trạm này?');"
                                                   class="bg-red-500 text-white px-3 py-1 rounded-md text-sm hover:bg-red-600 hover:shadow-md transition-all duration-150">
                                                    <i class="fa fa-trash"></i> Xóa
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" class="py-5 text-gray-500 italic border border-gray-300 text-center">Không có dữ liệu</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- Phân trang -->
            <div class="text-center mt-8 animate-[fadeSlideUp_1s_ease]">
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <a
                                href="StationServlet?action=list&page=${i}&search=${param.search}&sort=${param.sort}"
                                class="inline-block bg-gradient-to-r from-blue-500 to-green-400 text-white font-semibold px-3 py-2 rounded-md shadow hover:scale-105 mx-1"
                                >
                                ${i}
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a
                                href="StationServlet?action=list&page=${i}&search=${param.search}&sort=${param.sort}"
                                class="inline-block border border-blue-500 text-blue-500 font-medium px-3 py-2 rounded-md hover:bg-gradient-to-r hover:from-blue-500 hover:to-green-400 hover:text-white hover:shadow transition mx-1"
                                >
                                ${i}
                            </a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
        </div>
        <jsp:include page="/footer.jsp" />
    </body>
</html>

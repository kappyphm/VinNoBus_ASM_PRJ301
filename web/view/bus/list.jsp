<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/header.jsp" />

<html>
    <head>
        <title>Danh sách Bus</title>
        <script src="https://cdn.tailwindcss.com"></script>
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
            body {
                animation: fadeSlideUp 0.6s ease;
            }
        </style>
    </head>

    <body class="font-[Segoe_UI] bg-gradient-to-br from-[#eaf2f8] via-[#f5f7fa] to-[#e8f6f3] min-h-screen">
        <div class="w-[90%] mx-auto my-16 bg-white/90 backdrop-blur-sm p-10 rounded-2xl shadow-[0_12px_30px_rgba(0,0,0,0.08)] transition-all duration-300 animate-[fadeSlideUp_0.7s_ease]">

            <!-- Tiêu đề -->
            <h2 class="text-center text-3xl font-bold text-[#2c3e50] mb-8 relative
                after:content-[''] after:block after:w-32 after:h-1 after:rounded-full
                after:mx-auto after:mt-3 after:bg-gradient-to-r after:from-[#3498db]
                after:to-[#2ecc71] after:shadow-[0_2px_8px_rgba(52,152,219,0.4)]">
                Danh sách Bus
            </h2>

            <!-- Thông báo -->
            <c:if test="${not empty message}">
                <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-4 rounded-md animate-[fadeSlideUp_0.7s_ease]">
                    ${message}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4 rounded-md animate-[fadeSlideUp_0.7s_ease]">
                    ${error}
                </div>
            </c:if>

            <!-- Thanh công cụ -->
            <div class="flex flex-wrap justify-between items-center gap-3 mb-6 animate-[fadeSlideUp_0.8s_ease]">
                <a href="BusServlet?action=add"
                   class="bg-gradient-to-r from-[#3498db] to-[#2ecc71] text-white px-5 py-2.5 rounded-lg shadow-md hover:scale-[1.05] hover:shadow-lg transition duration-300 font-medium">
                    + Thêm Xe Bus
                </a>

                <!-- Form tìm kiếm -->
                <form method="get" action="BusServlet" class="flex items-center gap-2">
                    <input type="hidden" name="action" value="list" />
                    <input type="text" name="search" value="${fn:trim(param.search)}" placeholder="Nhập biển số..."
                           class="px-4 py-2 rounded-lg border border-gray-300 text-sm bg-gray-50 focus:outline-none focus:ring-2 focus:ring-blue-400 transition"/>
                    <button type="submit"
                            class="bg-gradient-to-r from-[#3498db] to-[#2ecc71] text-white px-4 py-2 rounded-lg shadow hover:scale-105 transition">
                        Tìm kiếm
                    </button>
                </form>

                <!-- Form sắp xếp -->
                <form method="get" action="BusServlet" class="flex items-center gap-2">
                    <input type="hidden" name="action" value="list" />
                    <select name="sort"
                            class="px-4 py-2 rounded-lg border border-gray-300 text-sm bg-gray-50 focus:ring-2 focus:ring-teal-400 transition">
                        <option value="bus_id ASC" ${param.sort == 'bus_id ASC' ? 'selected' : ''}>ID tăng dần</option>
                        <option value="bus_id DESC" ${param.sort == 'bus_id DESC' ? 'selected' : ''}>ID giảm dần</option>
                        <option value="plate_number ASC" ${param.sort == 'plate_number ASC' ? 'selected' : ''}>Biển số A-Z</option>
                        <option value="plate_number DESC" ${param.sort == 'plate_number DESC' ? 'selected' : ''}>Biển số Z-A</option>
                        <option value="capacity ASC" ${param.sort == 'capacity ASC' ? 'selected' : ''}>Chỗ ngồi tăng</option>
                        <option value="capacity DESC" ${param.sort == 'capacity DESC' ? 'selected' : ''}>Chỗ ngồi giảm</option>
                    </select>
                    <button type="submit"
                            class="bg-gradient-to-r from-[#16a085] to-[#1abc9c] text-white px-4 py-2 rounded-lg shadow hover:scale-105 transition">
                        Sắp xếp
                    </button>
                </form>
            </div>

            <!-- Bảng dữ liệu -->
            <div class="overflow-x-auto rounded-xl shadow-xl border border-gray-200 animate-[fadeSlideUp_0.9s_ease]">
                <table class="w-full border-collapse text-center text-[15px]">
                    <thead>
                        <tr class="bg-gradient-to-r from-[#3498db] via-[#2980b9] to-[#2ecc71] text-white uppercase text-sm">
                            <th class="py-3 px-4 border border-gray-200">ID</th>
                            <th class="py-3 px-4 border border-gray-200">Biển số</th>
                            <th class="py-3 px-4 border border-gray-200">Số chỗ ngồi</th>
                            <th class="py-3 px-4 border border-gray-200">Trạng thái</th>
                            <th class="py-3 px-4 border border-gray-200">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="bus" items="${busList}">
                            <tr class="even:bg-gray-50 odd:bg-white hover:bg-[#e8f4fd] transition duration-300">
                                <td class="py-3 px-4 border border-gray-200">${bus.busId}</td>
                                <td class="py-3 px-4 border border-gray-200">${bus.plateNumber}</td>
                                <td class="py-3 px-4 border border-gray-200">${bus.capacity}</td>
                                <td class="py-3 px-4 border border-gray-200">${bus.currentStatus}</td>
                                <td class="py-3 px-4 border border-gray-200 flex flex-wrap justify-center gap-2">
                                    <a href="BusServlet?action=edit&id=${bus.busId}"
                                       class="bg-gradient-to-r from-[#f39c12] to-[#f1c40f] text-white px-3 py-1.5 rounded-md hover:opacity-90 transition">✏️ Edit</a>
                                    <a href="BusServlet?action=delete&id=${bus.busId}"
                                       onclick="return confirm('Bạn có chắc muốn xóa?');"
                                       class="bg-gradient-to-r from-[#e74c3c] to-[#c0392b] text-white px-3 py-1.5 rounded-md hover:opacity-90 transition">🗑️ Delete</a>
                                    <a href="BusServlet?action=detail&id=${bus.busId}"
                                       class="bg-gradient-to-r from-[#3498db] to-[#2980b9] text-white px-3 py-1.5 rounded-md hover:opacity-90 transition">🚍 Details</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Phân trang -->
            <div class="text-center mt-8 animate-[fadeSlideUp_1s_ease]">
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <a href="BusServlet?action=list&page=${i}&search=${fn:trim(param.search)}&sort=${param.sort}"
                               class="inline-block bg-gradient-to-r from-[#3498db] to-[#2ecc71] text-white font-semibold px-3 py-2 rounded-md shadow hover:scale-105 mx-1">${i}</a>
                        </c:when>
                        <c:otherwise>
                            <a href="BusServlet?action=list&page=${i}&search=${fn:trim(param.search)}&sort=${param.sort}"
                               class="inline-block border border-[#3498db] text-[#3498db] font-medium px-3 py-2 rounded-md hover:bg-gradient-to-r hover:from-[#3498db] hover:to-[#2ecc71] hover:text-white hover:shadow transition mx-1">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
        </div>

        <jsp:include page="/footer.jsp" />
    </body>
</html>

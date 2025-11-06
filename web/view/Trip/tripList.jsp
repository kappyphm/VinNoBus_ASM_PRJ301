<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/header.jsp" %>

<script src="https://cdn.tailwindcss.com"></script>

<body class="min-h-screen bg-gradient-to-br from-indigo-50 via-purple-50 to-blue-100 font-['Segoe_UI'] p-6">
    <div class="max-w-7xl mx-auto">

        <h1 class="text-4xl font-bold text-center mb-8 bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent">
            Danh sách chuyến xe
        </h1>

        <div class="flex items-center justify-between bg-white/90 backdrop-blur-sm shadow-md px-6 py-4 rounded-2xl mb-6">
            <h2 class="text-xl font-semibold text-gray-800">Quản lý chuyến</h2>
            <a href="TripServlet?action=add" 
               class="bg-gradient-to-r from-indigo-500 to-purple-500 text-white px-5 py-2 rounded-xl shadow-md hover:shadow-lg transition-all duration-200 hover:scale-105">
                ➕ Tạo chuyến mới
            </a>
        </div>

        <form class="bg-white/90 backdrop-blur-sm p-6 rounded-2xl shadow-md flex flex-wrap items-center justify-center gap-4 mb-8" 
              action="TripServlet" method="get">

            <input type="hidden" name="action" value="list">

            <label class="font-medium text-gray-700">Lọc theo:</label>
            <select name="filter" class="border-gray-300 rounded-lg p-2 focus:ring-indigo-500 focus:border-indigo-500">
                <option value="">-- Chọn --</option>
                <option value="tripId" ${param.filter == 'tripId' ? 'selected' : ''}>Mã chuyến</option>
                <option value="busId" ${param.filter == 'busId' ? 'selected' : ''}>Mã xe buýt</option>
                <option value="routeId" ${param.filter == 'routeId' ? 'selected' : ''}>Mã tuyến</option>
                <option value="driverId" ${param.filter == 'driverId' ? 'selected' : ''}>Tài xế</option>
                <option value="conductorId" ${param.filter == 'conductorId' ? 'selected' : ''}>Phụ xe</option>
                <option value="status" ${param.filter == 'status' ? 'selected' : ''}>Trạng thái</option>
            </select>

            <label class="font-medium text-gray-700">Tìm kiếm:</label>
            <input type="text" name="search" value="${param.search}" placeholder="Nhập từ khóa..."
                   class="border-gray-300 rounded-lg p-2 focus:ring-indigo-500 focus:border-indigo-500"/>

            <label class="font-medium text-gray-700">Sắp xếp theo:</label>
            <select name="sortCol" class="border-gray-300 rounded-lg p-2 focus:ring-indigo-500 focus:border-indigo-500">
                <option value="trip_id" ${empty param.sortCol || param.sortCol == 'trip_id' ? 'selected' : ''}>Mã chuyến</option>
                <option value="status" ${param.sortCol == 'status' ? 'selected' : ''}>Trạng thái</option>
                <option value="departure_time" ${param.sortCol == 'departure_time' ? 'selected' : ''}>Giờ khởi hành</option>
                <option value="arrival_time" ${param.sortCol == 'arrival_time' ? 'selected' : ''}>Giờ kết thúc</option>
                <option value="bus_id" ${param.sortCol == 'bus_id' ? 'selected' : ''}>Mã xe buýt</option>
                <option value="route_id" ${param.sortCol == 'route_id' ? 'selected' : ''}>Mã tuyến</option>
                <option value="driver_id" ${param.sortCol == 'driver_id' ? 'selected' : ''}>Tài xế</option>
            </select>

            <label class="font-medium text-gray-700">Thứ tự:</label>
            <select name="sortDir" class="border-gray-300 rounded-lg p-2 focus:ring-indigo-500 focus:border-indigo-500">
                <option value="asc" ${empty param.sortDir || param.sortDir == 'asc' ? 'selected' : ''}>Tăng dần</option>
                <option value="desc" ${param.sortDir == 'desc' ? 'selected' : ''}>Giảm dần</option>
            </select>

            <button type="submit"
                    class="bg-gradient-to-r from-indigo-500 to-purple-500 text-white px-4 py-2 rounded-lg shadow-md hover:shadow-lg hover:scale-105 transition-all duration-200">
                🔍 Lọc
            </button>
        </form>

        <p class="text-red-500 text-center font-medium">${errorMessage}</p>

        <c:choose>
            <c:when test="${empty trips}">
                <p class="text-center italic text-gray-500">Không có chuyến xe nào để hiển thị.</p>
            </c:when>
            <c:otherwise>
                <div class="overflow-x-auto rounded-2xl shadow-lg bg-white">
                    <table class="min-w-full border-collapse">
                        <thead class="bg-gradient-to-r from-indigo-600 to-purple-600 text-white">
                            <tr>
                                <th class="py-3 px-4 text-center">STT</th>
                                <th class="py-3 px-4 text-center">Mã chuyến</th>
                                <th class="py-3 px-4 text-center">Mã tuyến</th>
                                <th class="py-3 px-4 text-center">Mã xe buýt</th>
                                <th class="py-3 px-4 text-center">Tài xế</th>
                                <th class="py-3 px-4 text-center">Phụ xe</th>
                                <th class="py-3 px-4 text-center">Giờ khởi hành</th>
                                <th class="py-3 px-4 text-center">Giờ kết thúc</th>
                                <th class="py-3 px-4 text-center">Trạng thái</th>
                                <th class="py-3 px-4 text-center">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="index" value="1"/>
                            <c:forEach var="t" items="${trips}">
                                <tr class="border-b hover:bg-indigo-50 transition">
                                    <td class="py-3 px-4 text-center">${(currentPage - 1) * pageSize + index}</td>
                                    <td class="py-3 px-4 text-center font-medium">${t.tripId}</td>
                                    <td class="py-3 px-4 text-center">${t.routeId}</td>
                                    <td class="py-3 px-4 text-center">${t.busId}</td>
                                    <td class="py-3 px-4 text-center">${t.driverId}</td>
                                    <td class="py-3 px-4 text-center">${t.conductorId}</td>
                                    <td class="py-3 px-4 text-center text-sm">
                                        <fmt:formatDate value="${t.departureTime}" pattern="HH:mm dd-MM-yyyy"/>
                                    </td>
                                    <td class="py-3 px-4 text-center text-sm">
                                        <fmt:formatDate value="${t.arrivalTime}" pattern="HH:mm dd-MM-yyyy"/>
                                    </td>
                                    <td class="py-3 px-4 text-center">
                                        <c:choose>
                                            <c:when test="${t.status eq 'NOT_STARTED'}">
                                                <span class="text-amber-600 font-semibold">Chưa bắt đầu</span>
                                            </c:when>
                                            <c:when test="${t.status eq 'IN_PROCESS'}">
                                                <span class="text-green-600 font-semibold">Đang chạy</span>
                                            </c:when>
                                            <c:when test="${t.status eq 'FINISHED'}">
                                                <span class="text-blue-600 font-semibold">Hoàn thành</span>
                                            </c:when>
                                            <c:when test="${t.status eq 'CANCELLED'}">
                                                <span class="text-red-500 font-semibold">Đã hủy</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td class="py-3 px-4 text-center space-x-2">
                                        <a href="TripServlet?action=detail&tripId=${t.tripId}" 
                                           class="text-indigo-600 hover:underline font-medium">Chi tiết</a>
                                        |
                                        <a href="TripServlet?action=edit&tripId=${t.tripId}" 
                                           class="text-purple-600 hover:underline font-medium">Sửa</a>
                                        |
                                        <form action="TripServlet" method="post" class="inline"
                                              onsubmit="return confirm('Bạn có chắc muốn xóa chuyến này không?')">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="tripId" value="${t.tripId}">
                                            <button type="submit" class="text-red-500 hover:underline font-medium bg-transparent border-none p-0 cursor-pointer">Xóa</button>
                                        </form>
                                    </td>
                                </tr>
                                <c:set var="index" value="${index + 1}"/>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <p class="text-right mt-4 font-semibold text-gray-700">
                    Tổng số chuyến: <span class="text-indigo-600">${total}</span>
                </p>

                <c:if test="${total > 0}">
                    <c:set var="pageSize" value="10"/>
                    <c:set var="totalPages" value="${(total + pageSize - 1) / pageSize}"/>
                    <c:set var="currentPage" value="${param.page != null ? param.page : 1}"/>

                    <c:set var="paginationParams" value="&action=list&search=${param.search}&filter=${param.filter}&sortCol=${param.sortCol}&sortDir=${param.sortDir}" />

                    <div class="flex justify-center mt-6 space-x-2">
                        <c:if test="${currentPage > 1}">
                            <a href="TripServlet?page=${currentPage - 1}${paginationParams}"
                               class="px-3 py-1 border border-indigo-400 text-indigo-600 rounded-lg hover:bg-indigo-50">«</a>
                        </c:if>

                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <a href="TripServlet?page=${i}${paginationParams}"
                               class="px-3 py-1 rounded-lg border border-indigo-400 hover:bg-indigo-500 hover:text-white transition
                               ${i == currentPage ? 'bg-indigo-500 text-white' : 'text-indigo-600'}">${i}</a>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <a href="TripServlet?page=${currentPage + 1}${paginationParams}"
                               class="px-3 py-1 border border-indigo-400 text-indigo-600 rounded-lg hover:bg-indigo-50">»</a>
                        </c:if>
                    </div>
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>
</body>

<%@ include file="/footer.jsp" %>
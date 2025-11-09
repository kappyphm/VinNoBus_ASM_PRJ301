<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>

<ui:layout>
    <jsp:attribute name="title">Danh sách chuyến xe • VinNoBus</jsp:attribute>

    <jsp:body>
        <script src="https://cdn.tailwindcss.com"></script>

        <div class="min-h-screen bg-gray-50 font-mono p-6">
            <div class="mx-auto max-w-7xl">

                <!-- Header -->
                <h1 class="text-4xl font-bold text-center mb-8 text-brand-600">
                    Quản lý chuyến xe
                </h1>

                <!-- Header Card -->
                <div class="flex flex-col md:flex-row items-center justify-between gap-4 bg-white rounded-2xl shadow-lg px-8 py-6 mb-6">
                    <h2 class="text-xl font-semibold text-gray-800">Danh sách chuyến</h2>
                    <a href="TripServlet?action=add" 
                       class="flex items-center gap-2 bg-gradient-to-r from-blue-600 to-blue-400 text-white px-5 py-2.5 rounded-xl shadow hover:shadow-lg transition transform hover:scale-105">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd" />
                        </svg>
                        Tạo chuyến mới
                    </a>
                </div>

                <!-- Filter & Search Card -->
                <form class="bg-white rounded-2xl shadow p-6 flex flex-wrap gap-4 mb-8"
                      action="TripServlet" method="get">
                    <input type="hidden" name="action" value="list">

                        <div class="flex-grow min-w-[150px]">
                            <label class="block text-sm font-medium text-gray-700 mb-1">Lọc theo</label>
                            <select name="filter" class="w-full border-gray-300 rounded-lg p-2 shadow-sm focus:ring-2 focus:ring-blue-400 focus:border-blue-400 transition duration-150">
                                <option value="">-- Tất cả --</option>
                                <option value="tripId" ${param.filter == 'tripId' ? 'selected' : ''}>Mã chuyến</option>
                                <option value="busId" ${param.filter == 'busId' ? 'selected' : ''}>Mã xe buýt</option>
                                <option value="routeId" ${param.filter == 'routeId' ? 'selected' : ''}>Mã tuyến</option>
                                <option value="driverId" ${param.filter == 'driverId' ? 'selected' : ''}>Tài xế</option>
                                <option value="conductorId" ${param.filter == 'conductorId' ? 'selected' : ''}>Phụ xe</option>
                                <option value="status" ${param.filter == 'status' ? 'selected' : ''}>Trạng thái</option>
                            </select>
                        </div>

                        <div class="flex-grow min-w-[200px]">
                            <label class="block text-sm font-medium text-gray-700 mb-1">Tìm kiếm</label>
                            <input type="text" name="search" value="${param.search}" placeholder="Nhập từ khóa..."
                                   class="w-full border-gray-300 rounded-lg p-2 shadow-sm focus:ring-2 focus:ring-blue-400 focus:border-blue-400 transition duration-150"/>
                        </div>

                        <div class="flex-grow min-w-[150px]">
                            <label class="block text-sm font-medium text-gray-700 mb-1">Sắp xếp theo</label>
                            <select name="sortCol" class="w-full border-gray-300 rounded-lg p-2 shadow-sm focus:ring-2 focus:ring-blue-400 focus:border-blue-400 transition duration-150">
                                <option value="trip_id" ${empty param.sortCol || param.sortCol == 'trip_id' ? 'selected' : ''}>Mã chuyến</option>
                                <option value="departure_time" ${param.sortCol == 'departure_time' ? 'selected' : ''}>Giờ khởi hành</option>
                                <option value="arrival_time" ${param.sortCol == 'arrival_time' ? 'selected' : ''}>Giờ kết thúc</option>
                                <option value="bus_id" ${param.sortCol == 'bus_id' ? 'selected' : ''}>Mã xe buýt</option>
                                <option value="route_id" ${param.sortCol == 'route_id' ? 'selected' : ''}>Mã tuyến</option>
                                <option value="driver_id" ${param.sortCol == 'driver_id' ? 'selected' : ''}>Tài xế</option>
                                <option value="conductor_id" ${param.sortCol == 'conductor_id' ? 'selected' : ''}>Phụ xe</option>
                            </select>
                        </div>

                        <div class="flex-grow min-w-[120px]">
                            <label class="block text-sm font-medium text-gray-700 mb-1">Thứ tự</label>
                            <select name="sortDir" class="w-full border-gray-300 rounded-lg p-2 shadow-sm focus:ring-2 focus:ring-blue-400 focus:border-blue-400 transition duration-150">
                                <option value="asc" ${empty param.sortDir || param.sortDir == 'asc' ? 'selected' : ''}>Tăng dần</option>
                                <option value="desc" ${param.sortDir == 'desc' ? 'selected' : ''}>Giảm dần</option>
                            </select>
                        </div>

                        <div class="self-end">
                            <button type="submit" class="flex items-center gap-2 bg-blue-600 text-white px-5 py-2.5 rounded-xl shadow hover:bg-blue-700 transition transform hover:scale-105">
                                Lọc
                            </button>
                        </div>
                </form>

                <!-- Table Card -->
                <div class="bg-white rounded-2xl shadow-lg overflow-x-auto">
                    <table class="min-w-full text-xs font-mono">
                        <thead class="bg-blue-600 text-white text-sm">
                            <tr>
                                <th class="px-4 py-2 text-center font-semibold uppercase tracking-wider">STT</th>
                                <th class="px-4 py-2 text-center font-semibold uppercase tracking-wider">Mã chuyến</th>
                                <th class="px-4 py-2 text-center font-semibold uppercase tracking-wider">Mã tuyến</th>
                                <th class="px-4 py-2 text-center font-semibold uppercase tracking-wider">Mã xe buýt</th>
                                <th class="px-4 py-2 text-center font-semibold uppercase tracking-wider">Tài xế</th>
                                <th class="px-4 py-2 text-center font-semibold uppercase tracking-wider">Phụ xe</th>
                                <th class="px-4 py-2 text-center font-semibold uppercase tracking-wider">Khởi hành</th>
                                <th class="px-4 py-2 text-center font-semibold uppercase tracking-wider">Kết thúc</th>
                                <th class="px-4 py-2 text-center font-semibold uppercase tracking-wider">Trạng thái</th>
                                <th class="px-4 py-2 text-center font-semibold uppercase tracking-wider">Hành động</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200 text-[13px]">
                            <c:forEach var="t" items="${trips}" varStatus="status">
                                <tr class="hover:bg-gray-50 transition duration-150 whitespace-nowrap">
                                    <td class="px-2 py-2 text-center text-gray-500">${(currentPage - 1) * pageSize + status.index + 1}</td>
                                    <td class="px-2 py-2 text-center text-gray-900 font-medium">${t.tripId}</td>
                                    <td class="px-2 py-2 text-center text-gray-700">${t.routeId}</td>
                                    <td class="px-2 py-2 text-center text-gray-700">${t.busId}</td>
                                    <td class="px-2 py-2 text-center text-gray-700">${t.driverId}</td>
                                    <td class="px-2 py-2 text-center text-gray-700">${t.conductorId}</td>
                                    <td class="px-2 py-2 text-center text-gray-700"><fmt:formatDate value="${t.departureTime}" pattern="HH:mm dd-MM-yyyy"/></td>
                                    <td class="px-2 py-2 text-center text-gray-700"><fmt:formatDate value="${t.arrivalTime}" pattern="HH:mm dd-MM-yyyy"/></td>
                                    <!-- Trạng thái -->
                                    <td class="px-2 py-2 text-center">
                                        <c:set var="statusClass" value=""/>
                                        <c:set var="statusText" value=""/>
                                        <c:choose>
                                            <c:when test="${t.status eq 'NOT_STARTED'}">
                                                <c:set var="statusClass" value="bg-yellow-100 text-yellow-800"/>
                                                <c:set var="statusText" value="Chưa bắt đầu"/>
                                            </c:when>
                                            <c:when test="${t.status eq 'IN_PROCESS'}">
                                                <c:set var="statusClass" value="bg-green-100 text-green-800"/>
                                                <c:set var="statusText" value="Đang chạy"/>
                                            </c:when>
                                            <c:when test="${t.status eq 'FINISHED'}">
                                                <c:set var="statusClass" value="bg-blue-100 text-blue-800"/>
                                                <c:set var="statusText" value="Hoàn thành"/>
                                            </c:when>
                                            <c:when test="${t.status eq 'CANCELLED'}">
                                                <c:set var="statusClass" value="bg-red-100 text-red-800"/>
                                                <c:set var="statusText" value="Đã hủy"/>
                                            </c:when>
                                        </c:choose>
                                        <span class="px-2 py-1 inline-flex text-[11px] leading-4 font-semibold rounded-full ${statusClass}">${statusText}</span>
                                    </td>
                                    <!-- Hành động -->
                                    <td class="px-2 py-2 text-center text-[12px] font-medium flex justify-center gap-2">
                                        <a href="TripServlet?action=detail&tripId=${t.tripId}" class="text-blue-600 hover:text-blue-900">👁 Chi tiết️</a>
                                        <a href="TripServlet?action=edit&tripId=${t.tripId}" class="text-purple-600 hover:text-purple-900">✏️ Sửa</a>
                                        <form action="TripServlet" method="post" onsubmit="return confirm('Bạn có chắc muốn xóa chuyến ${t.tripId} không?')">
                                            <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="tripId" value="${t.tripId}">
                                                    <button type="submit" class="text-red-600 hover:text-red-900 bg-transparent border-none p-0 cursor-pointer">❌ Xóa</button>
                                                    </form>
                                                    </td>
                                                    </tr>
                                                </c:forEach>
                                                </tbody>
                                                </table>
                                                </div>
                                                </div>
                                                </div>
                                            </jsp:body>
                                        </ui:layout>

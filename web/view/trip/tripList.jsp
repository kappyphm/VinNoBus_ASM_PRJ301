<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>

<ui:layout>
    <jsp:attribute name="title">Danh sách chuyến xe • VinNoBus</jsp:attribute>

    <jsp:body>
        <script src="https://cdn.tailwindcss.com"></script>

        <div class="min-h-screen bg-gray-50 font-sans p-6">
            <div class="mx-auto"> 
                <h1 class="text-4xl font-bold text-center mb-8 bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent py-2">
                    Quản lý chuyến xe
                </h1>

                <!-- Filter & Create Button -->
                <div class="flex flex-col md:flex-row items-center justify-between gap-4 bg-white shadow-md px-6 py-4 rounded-xl mb-6">
                    <h2 class="text-xl font-semibold text-gray-800">Danh sách chuyến</h2>
                    <a href="TripServlet?action=add" 
                       class="flex items-center gap-2 bg-gradient-to-r from-indigo-500 to-purple-500 text-white px-5 py-2.5 rounded-lg shadow-md hover:shadow-lg transition-all duration-300 hover:scale-105 transform">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd" />
                        </svg>
                        Tạo chuyến mới
                    </a>
                </div>

                <!-- Search & Filter Form -->
                <form class="bg-white p-6 rounded-xl shadow-md flex flex-wrap items-center justify-start gap-x-6 gap-y-4 mb-8" 
                      action="TripServlet" method="get">
                    <input type="hidden" name="action" value="list">

                        <!-- Filter select -->
                        <div class="flex-grow min-w-[150px]">
                            <label for="filterSelect" class="block text-sm font-medium text-gray-700 mb-1">Lọc theo</label>
                            <select name="filter" id="filterSelect" class="w-full border-gray-300 rounded-lg p-2 shadow-sm focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 transition duration-150">
                                <option value="">-- Tất cả --</option>
                                <option value="tripId" ${param.filter == 'tripId' ? 'selected' : ''}>Mã chuyến</option>
                                <option value="busId" ${param.filter == 'busId' ? 'selected' : ''}>Mã xe buýt</option>
                                <option value="routeId" ${param.filter == 'routeId' ? 'selected' : ''}>Mã tuyến</option>
                                <option value="driverId" ${param.filter == 'driverId' ? 'selected' : ''}>Tài xế</option>
                                <option value="conductorId" ${param.filter == 'conductorId' ? 'selected' : ''}>Phụ xe</option>
                                <option value="status" ${param.filter == 'status' ? 'selected' : ''}>Trạng thái</option>
                            </select>
                        </div>

                        <!-- Search input -->
                        <div class="flex-grow min-w-[200px]">
                            <label for="searchInput" class="block text-sm font-medium text-gray-700 mb-1">Tìm kiếm</label>
                            <input type="text" name="search" id="searchInput" value="${param.search}" placeholder="Nhập từ khóa..."
                                   class="w-full border-gray-300 rounded-lg p-2 shadow-sm focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 transition duration-150"/>
                        </div>

                        <!-- Sort Column -->
                        <div class="flex-grow min-w-[150px]">
                            <label for="sortCol" class="block text-sm font-medium text-gray-700 mb-1">Sắp xếp theo</label>
                            <select name="sortCol" id="sortCol" class="w-full border-gray-300 rounded-lg p-2 shadow-sm focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 transition duration-150">
                                <option value="trip_id" ${empty param.sortCol || param.sortCol == 'trip_id' ? 'selected' : ''}>Mã chuyến</option>
                                <option value="departure_time" ${param.sortCol == 'departure_time' ? 'selected' : ''}>Giờ khởi hành</option>
                                <option value="arrival_time" ${param.sortCol == 'arrival_time' ? 'selected' : ''}>Giờ kết thúc</option>
                                <option value="bus_id" ${param.sortCol == 'bus_id' ? 'selected' : ''}>Mã xe buýt</option>
                                <option value="route_id" ${param.sortCol == 'route_id' ? 'selected' : ''}>Mã tuyến</option>
                                <option value="driver_id" ${param.sortCol == 'driver_id' ? 'selected' : ''}>Tài xế</option>
                                <option value="conductor_id" ${param.sortCol == 'conductor_id' ? 'selected' : ''}>Phụ xe</option>
                            </select>
                        </div>

                        <!-- Sort Direction -->
                        <div class="flex-grow min-w-[120px]">
                            <label for="sortDir" class="block text-sm font-medium text-gray-700 mb-1">Thứ tự</label>
                            <select name="sortDir" id="sortDir" class="w-full border-gray-300 rounded-lg p-2 shadow-sm focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 transition duration-150">
                                <option value="asc" ${empty param.sortDir || param.sortDir == 'asc' ? 'selected' : ''}>Tăng dần</option>
                                <option value="desc" ${param.sortDir == 'desc' ? 'selected' : ''}>Giảm dần</option>
                            </select>
                        </div>

                        <!-- Submit button -->
                        <div class="self-end">
                            <button type="submit" class="flex items-center gap-2 bg-indigo-600 text-white px-5 py-2.5 rounded-lg shadow-md hover:bg-indigo-700 transition-all duration-200 transform hover:scale-105">
                                Lọc
                            </button>
                        </div>
                </form>

                <!-- Messages -->
                <c:if test="${not empty errorMessage}">
                    <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded-lg mb-6 shadow-md" role="alert">
                        <p class="font-bold">❌ Đã xảy ra lỗi</p>
                        <p>${errorMessage}</p>
                    </div>
                </c:if>

                <c:if test="${not empty success}">
                    <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded-lg mb-6 shadow-md" role="alert">
                        <p class="font-bold">✅ Thành công!</p>
                        <p>${success}</p>
                    </div>
                </c:if>

                <!-- Table of trips -->
                <c:choose>
                    <c:when test="${empty trips}">
                        <div class="bg-white rounded-xl shadow-md p-10 text-center">
                            <p class="text-xl italic text-gray-500">Không có chuyến xe nào để hiển thị.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Table code here ... -->
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </jsp:body>
</ui:layout>

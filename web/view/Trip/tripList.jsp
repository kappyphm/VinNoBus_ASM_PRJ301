<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>

<ui:layout>
    <jsp:attribute name="title">Danh sách Chuyến xe • VinNoBus</jsp:attribute>

    <jsp:body>
        <main class="min-h-screen bg-brand-50 p-8">

            <div class="max-w-7xl mx-auto">

                <!-- Header -->
                <div class="flex flex-wrap justify-between items-center mb-6">
                    <h1 class="text-3xl font-semibold text-slate-900">Danh sách chuyến xe</h1>
                    <a href="TripServlet?action=add"
                       class="px-5 py-2 rounded-xl bg-brand-600 text-white text-sm font-medium shadow-soft hover:bg-brand-700 transition">
                        ➕ Tạo chuyến mới
                    </a>
                </div>

                <!-- Form lọc & tìm kiếm -->
                <form action="TripServlet" method="get" class="flex flex-wrap gap-3 mb-6 bg-white p-4 rounded-2xl shadow-soft">
                    <input type="hidden" name="action" value="search">

                    <div class="flex flex-col">
                        <label class="text-sm font-medium">Lọc theo</label>
                        <select name="filter" class="px-3 py-2 rounded-xl border border-slate-300 focus:ring-2 focus:ring-brand-500 outline-none">
                            <option value="">-- Chọn --</option>
                            <option value="tripId" ${param.filter == 'tripId' ? 'selected' : ''}>Mã chuyến</option>
                            <option value="busId" ${param.filter == 'busId' ? 'selected' : ''}>Mã xe buýt</option>
                            <option value="routeId" ${param.filter == 'routeId' ? 'selected' : ''}>Mã tuyến</option>
                            <option value="driverId" ${param.filter == 'driverId' ? 'selected' : ''}>Tài xế</option>
                            <option value="conductorId" ${param.filter == 'conductorId' ? 'selected' : ''}>Phụ xe</option>
                        </select>
                    </div>

                    <div class="flex flex-col">
                        <label class="text-sm font-medium">Tìm kiếm</label>
                        <input type="text" name="search" value="${param.search}" placeholder="Nhập từ khóa..."
                               class="px-3 py-2 rounded-xl border border-slate-300 focus:ring-2 focus:ring-brand-500 outline-none">
                    </div>

                    <div class="flex flex-col">
                        <label class="text-sm font-medium">Sắp xếp</label>
                        <select name="sort" class="px-3 py-2 rounded-xl border border-slate-300 focus:ring-2 focus:ring-brand-500 outline-none">
                            <option value="">-- Không --</option>
                            <option value="asc" ${param.sort == 'asc' ? 'selected' : ''}>Tăng dần</option>
                            <option value="desc" ${param.sort == 'desc' ? 'selected' : ''}>Giảm dần</option>
                        </select>
                    </div>

                    <div class="self-end">
                        <button type="submit" class="px-4 py-2 rounded-xl bg-brand-600 text-white text-sm font-medium hover:bg-brand-700 transition">
                            🔍 Tìm
                        </button>
                    </div>
                </form>

                <!-- Table -->
                <c:choose>
                    <c:when test="${empty trips}">
                        <p class="text-center text-slate-500 italic">Không có chuyến xe nào để hiển thị.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="overflow-x-auto bg-white rounded-2xl shadow-soft">
                            <table class="min-w-full text-sm divide-y divide-slate-200">
                                <thead class="bg-brand-100 text-left text-slate-700">
                                    <tr>
                                        <th class="py-2 px-4">STT</th>
                                        <th class="py-2 px-4">Mã chuyến</th>
                                        <th class="py-2 px-4">Mã tuyến</th>
                                        <th class="py-2 px-4">Mã xe buýt</th>
                                        <th class="py-2 px-4">Tài xế</th>
                                        <th class="py-2 px-4">Phụ xe</th>
                                        <th class="py-2 px-4">Giờ khởi hành</th>
                                        <th class="py-2 px-4">Giờ kết thúc</th>
                                        <th class="py-2 px-4">Trạng thái</th>
                                        <th class="py-2 px-4">Hành động</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-slate-100">
                                    <c:set var="index" value="1" />
                                    <c:forEach var="t" items="${trips}">
                                        <tr class="hover:bg-brand-50 transition">
                                            <td class="py-2 px-4">${index}</td>
                                            <td class="py-2 px-4">${t.tripId}</td>
                                            <td class="py-2 px-4">${t.routeId}</td>
                                            <td class="py-2 px-4">${t.busId}</td>
                                            <td class="py-2 px-4">${t.driverId}</td>
                                            <td class="py-2 px-4">${t.conductorId}</td>
                                            <td class="py-2 px-4"><fmt:formatDate value="${t.departureTime}" pattern="HH:mm:ss"/></td>
                                            <td class="py-2 px-4"><fmt:formatDate value="${t.arrivalTime}" pattern="HH:mm:ss"/></td>
                                            <td class="py-2 px-4">
                                                <c:choose>
                                                    <c:when test="${t.status eq 'IN_PROGRESS'}">
                                                        <span class="px-2 py-1 rounded-xl bg-yellow-300 text-yellow-900 font-semibold text-xs">Đang chạy</span>
                                                    </c:when>
                                                    <c:when test="${t.status eq 'COMPLETED'}">
                                                        <span class="px-2 py-1 rounded-xl bg-green-300 text-green-900 font-semibold text-xs">Hoàn thành</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="px-2 py-1 rounded-xl bg-slate-300 text-slate-700 font-semibold text-xs">Chưa bắt đầu</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="py-2 px-4 flex gap-2 flex-wrap">
                                                <a href="TripServlet?action=detail&tripId=${t.tripId}" class="text-blue-600 hover:underline text-xs">Chi tiết</a>
                                                <a href="TripServlet?action=edit&tripId=${t.tripId}" class="text-yellow-600 hover:underline text-xs">Sửa</a>
                                                <a href="TripServlet?action=delete&tripId=${t.tripId}" 
                                                   onclick="return confirm('Bạn có chắc muốn xóa chuyến này không?')"
                                                   class="text-red-600 hover:underline text-xs">Xóa</a>
                                            </td>
                                        </tr>
                                        <c:set var="index" value="${index + 1}" />
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Tổng số -->
                        <p class="mt-3 text-right font-medium text-slate-700">Tổng số chuyến: <strong>${total}</strong></p>

                        <!-- Pagination -->
                        <c:if test="${total > 0}">
                            <c:set var="pageSize" value="10" />
                            <c:set var="totalPages" value="${(total + pageSize - 1) / pageSize}" />
                            <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />

                            <div class="flex justify-center gap-2 mt-4">
                                <c:if test="${currentPage > 1}">
                                    <a href="TripServlet?page=${currentPage - 1}&action=list&search=${param.search}&filter=${param.filter}&sort=${param.sort}"
                                       class="px-3 py-1 border border-brand-600 rounded-xl text-brand-600 hover:bg-brand-600 hover:text-white transition">«</a>
                                </c:if>

                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <a href="TripServlet?page=${i}&action=list&search=${param.search}&filter=${param.filter}&sort=${param.sort}"
                                       class="px-3 py-1 rounded-xl border ${i == currentPage ? 'bg-brand-600 text-white border-brand-600' : 'border-brand-600 text-brand-600'} hover:bg-brand-600 hover:text-white transition">
                                        ${i}
                                    </a>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <a href="TripServlet?page=${currentPage + 1}&action=list&search=${param.search}&filter=${param.filter}&sort=${param.sort}"
                                       class="px-3 py-1 border border-brand-600 rounded-xl text-brand-600 hover:bg-brand-600 hover:text-white transition">»</a>
                                </c:if>
                            </div>
                        </c:if>
                    </c:otherwise>
                </c:choose>

            </div>

        </main>
    </jsp:body>
</ui:layout>

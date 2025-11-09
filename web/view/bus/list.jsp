<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>

<ui:layout>
    <jsp:attribute name="title">Danh sách Bus • VinNoBus</jsp:attribute>

    <jsp:body>
        <main class="max-w-6xl mx-auto px-5 py-8">

            <!-- Tiêu đề -->
            <h1 class="text-3xl mb-2 font-normal">Danh sách Bus</h1>
            <p class="text-sm text-slate-600 mb-6">Quản lý xe bus: tìm kiếm, sắp xếp và thao tác chi tiết.</p>

            <!-- Messages -->
            <c:if test="${not empty message}">
                <div class="mb-4 p-4 rounded-2xl bg-green-50 border border-green-200 text-green-700 shadow-soft fade-up">
                    ${message}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="mb-4 p-4 rounded-2xl bg-red-50 border border-red-200 text-red-700 shadow-soft fade-up">
                    ${error}
                </div>
            </c:if>

            <!-- Toolbar -->
            <div class="flex flex-wrap items-center justify-between gap-3 mb-6 fade-up">
                <a href="BusServlet?action=add"
                   class="px-5 py-2 rounded-2xl bg-brand-600 text-white shadow-soft hover:bg-brand-700 transition">
                    + Thêm Xe Bus
                </a>

                <div class="flex flex-wrap gap-2">
                    <form method="get" action="BusServlet" class="flex gap-2">
                        <input type="hidden" name="action" value="list" />
                        <input type="text" name="search" value="${fn:trim(param.search)}"
                               placeholder="Nhập biển số..."
                               class="px-3 py-2 rounded-2xl border border-slate-300 focus:ring-1 focus:ring-brand-500 focus:outline-none text-sm font-normal">
                        <button class="px-4 py-2 rounded-2xl bg-brand-600 text-white text-sm hover:bg-brand-700 transition font-normal">
                            Tìm kiếm
                        </button>
                    </form>

                    <form method="get" action="BusServlet" class="flex gap-2">
                        <input type="hidden" name="action" value="list" />
                        <select name="sort" class="px-3 py-2 rounded-2xl border border-slate-300 text-sm focus:ring-1 focus:ring-brand-500 focus:outline-none font-normal">
                            <option value="bus_id ASC" ${param.sort == 'bus_id ASC' ? 'selected' : ''}>ID tăng dần</option>
                            <option value="bus_id DESC" ${param.sort == 'bus_id DESC' ? 'selected' : ''}>ID giảm dần</option>
                            <option value="plate_number ASC" ${param.sort == 'plate_number ASC' ? 'selected' : ''}>Biển số A-Z</option>
                            <option value="plate_number DESC" ${param.sort == 'plate_number DESC' ? 'selected' : ''}>Biển số Z-A</option>
                            <option value="capacity ASC" ${param.sort == 'capacity ASC' ? 'selected' : ''}>Chỗ ngồi tăng</option>
                            <option value="capacity DESC" ${param.sort == 'capacity DESC' ? 'selected' : ''}>Chỗ ngồi giảm</option>
                        </select>
                        <button class="px-4 py-2 rounded-2xl bg-brand-600 text-white text-sm hover:bg-brand-700 transition font-normal">
                            Sắp xếp
                        </button>
                    </form>
                </div>
            </div>

            <!-- Bảng danh sách Bus -->
            <div class="overflow-x-auto rounded-2xl border border-slate-200 bg-white shadow-soft fade-up">
                <table class="min-w-full text-sm font-normal">
                    <thead class="bg-brand-100 text-left text-slate-700 border-b border-slate-200">
                        <tr>
                            <th class="py-3 px-4 font-normal">ID</th>
                            <th class="py-3 px-4 font-normal">Biển số</th>
                            <th class="py-3 px-4 font-normal">Chỗ ngồi</th>
                            <th class="py-3 px-4 font-normal">Trạng thái</th>
                            <th class="py-3 px-4 font-normal">Hành động</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100 font-normal">
                        <c:forEach var="bus" items="${busList}">
                            <tr class="hover:bg-brand-50 transition-all font-normal">
                                <td class="py-2 px-4">${bus.busId}</td>
                                <td class="py-2 px-4">${bus.plateNumber}</td>
                                <td class="py-2 px-4">${bus.capacity}</td>
                                <td class="py-2 px-4">${bus.currentStatus}</td>
                                <td class="py-2 px-4 flex gap-2 flex-wrap">
                                    <a href="BusServlet?action=edit&id=${bus.busId}" class="px-3 py-1.5 rounded-xl bg-yellow-600 text-white text-xs hover:bg-yellow-700 transition font-normal">
                                        ✏️ Edit
                                    </a>
                                    <a href="BusServlet?action=delete&id=${bus.busId}" onclick="return confirm('Bạn có chắc muốn xóa?');" class="px-3 py-1.5 rounded-xl bg-red-600 text-white text-xs hover:bg-red-700 transition font-normal">
                                        🗑️ Delete
                                    </a>
                                    <a href="BusServlet?action=detail&id=${bus.busId}" class="px-3 py-1.5 rounded-xl bg-brand-600 text-white text-xs hover:bg-brand-700 transition font-normal">
                                        🚍 Details
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Phân trang -->
            <div class="mt-6 text-center fade-up font-normal">
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <span class="inline-block px-3 py-2 rounded-2xl bg-brand-600 text-white shadow-soft mx-1 text-sm font-normal">${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="BusServlet?action=list&page=${i}&search=${fn:trim(param.search)}&sort=${param.sort}"
                               class="inline-block px-3 py-2 rounded-2xl border border-brand-600 text-brand-600 hover:bg-brand-600 hover:text-white mx-1 text-sm transition font-normal">
                                ${i}
                            </a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>           
        </main>
    </jsp:body>
</ui:layout>

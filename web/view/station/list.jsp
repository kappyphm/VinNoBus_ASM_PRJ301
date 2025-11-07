<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>

<ui:layout>
    <jsp:attribute name="title">Danh sách trạm</jsp:attribute>

    <jsp:body>
        <main class="max-w-7xl mx-auto px-6 py-10">

            <!-- Page Title -->
            <div class="mb-10 text-center">
                <h1 class="text-2xl font-semibold">Danh sách trạm xe buýt</h1>
                <p class="text-sm text-slate-500 mt-1">Quản lý các trạm trong hệ thống VinNoBus</p>
            </div>

            <!-- Alerts -->
            <c:if test="${not empty error}">
                <div class="p-4 mb-4 rounded-xl bg-red-50 text-red-700 border border-red-200 shadow-soft">
                    ${error}
                </div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="p-4 mb-4 rounded-xl bg-green-50 text-green-700 border border-green-200 shadow-soft">
                    ${message}
                </div>
            </c:if>

            <!-- Toolbar -->
            <div class="flex flex-wrap justify-between items-center mb-6 gap-4">
                <a href="StationServlet?action=new"
                   class="px-4 py-2 rounded-xl bg-brand-600 text-white text-sm font-medium hover:bg-brand-700 shadow-soft transition">
                    + Thêm trạm mới
                </a>
                <form method="get" class="flex items-center gap-2">
                    <input type="text" name="search" value="${param.search}"
                           placeholder="Tìm kiếm trạm..."
                           class="rounded-xl border border-slate-300 px-3 py-2 text-sm bg-white focus:outline-none focus:ring-2 focus:ring-brand-400">
                    <button type="submit"
                            class="px-4 py-2 rounded-xl bg-brand-600 text-white text-sm hover:bg-brand-700 shadow-soft">
                        Tìm
                    </button>
                </form>
            </div>

            <!-- Table -->
            <div class="overflow-x-auto bg-white border border-slate-200 rounded-xl shadow-soft">
                <table class="min-w-full text-sm">
                    <thead class="bg-brand-100 shadow-soft">
                        <tr>
                            <th class="py-3 px-4 text-left font-medium border-b border-slate-200">ID</th>
                            <th class="py-3 px-4 text-left font-medium border-b border-slate-200">Tên trạm</th>
                            <th class="py-3 px-4 text-left font-medium border-b border-slate-200">Vị trí</th>
                            <th class="py-3 px-4 text-left font-medium border-b border-slate-200">Tuyến đi qua</th>
                            <th class="py-3 px-4 text-left font-medium border-b border-slate-200">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100">
                        <c:choose>
                            <c:when test="${not empty stations}">
                                <c:forEach var="s" items="${stations}">
                                    <tr class="hover:bg-brand-50 transition">
                                        <td class="py-3 px-4">${s.stationId}</td>
                                        <td class="py-3 px-4">${s.stationName}</td>
                                        <td class="py-3 px-4">${s.location}</td>
                                        <td class="py-3 px-4">
                                            <c:forEach var="r" items="${s.routeNames}" varStatus="loop">
                                                ${r}<c:if test="${!loop.last}">, </c:if>
                                            </c:forEach>
                                        </td>
                                        <td class="py-3 px-4">
                                            <div class="flex gap-2">
                                                <a href="StationServlet?action=view&id=${s.stationId}"
                                                   class="px-3 py-1 rounded-lg bg-slate-200 text-slate-700 text-xs hover:bg-slate-300">
                                                    Xem
                                                </a>
                                                <a href="StationServlet?action=edit&id=${s.stationId}"
                                                   class="px-3 py-1 rounded-lg bg-brand-500 text-white text-xs hover:bg-brand-600">
                                                    Sửa
                                                </a>
                                                <a href="StationServlet?action=delete&id=${s.stationId}"
                                                   onclick="return confirm('Xóa trạm này?');"
                                                   class="px-3 py-1 rounded-lg bg-red-500 text-white text-xs hover:bg-red-600">
                                                    Xóa
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" class="py-5 text-center text-slate-500 italic">
                                        Không có dữ liệu.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <div class="mt-8 flex justify-center gap-2">
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <span class="px-3 py-2 rounded-lg bg-brand-600 text-white text-sm shadow-soft">${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="StationServlet?action=list&page=${i}&search=${param.search}"
                               class="px-3 py-2 rounded-lg border border-brand-300 text-brand-600 text-sm hover:bg-brand-50 transition">
                                ${i}
                            </a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>

        </main>
    </jsp:body>
</ui:layout>

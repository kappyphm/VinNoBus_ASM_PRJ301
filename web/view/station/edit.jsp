<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>

<ui:layout>
    <jsp:attribute name="title">Cập nhật trạm • VinNoBus</jsp:attribute>

    <jsp:body>
        <main class="flex items-center justify-center min-h-screen p-6 bg-brand-50">

            <div class="bg-white w-full max-w-lg p-8 border border-slate-200 rounded-2xl shadow-soft animate-fadeIn">

                <h2 class="text-xl font-semibold text-center mb-6">Cập nhật thông tin trạm</h2>

                <!-- Lỗi -->
                <c:if test="${not empty error}">
                    <div class="p-3 bg-red-50 border border-red-200 text-red-700 rounded-xl text-sm mb-4 text-center shadow-soft">
                        ${error}
                    </div>
                </c:if>

                <c:choose>
                    <c:when test="${not empty station}">
                        <form action="StationServlet" method="post" class="space-y-6">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="stationId" value="${station.stationId}">

                            <!-- Tên trạm -->
                            <div>
                                <label class="block text-sm mb-1 text-slate-600">Tên trạm</label>
                                <input type="text" name="stationName" value="${station.stationName}" required
                                       class="w-full px-3 py-2 rounded-xl border border-slate-300 bg-white
                                       focus:ring-2 focus:ring-brand-400 focus:border-brand-400 transition">
                            </div>

                            <!-- Vị trí -->
                            <div>
                                <label class="block text-sm mb-1 text-slate-600">Vị trí</label>
                                <input type="text" name="location" value="${station.location}" required
                                       class="w-full px-3 py-2 rounded-xl border border-slate-300 bg-white
                                       focus:ring-2 focus:ring-brand-400 focus:border-brand-400 transition">
                            </div>

                            <!-- Nút -->
                            <div class="flex justify-between mt-4">
                                <a href="StationServlet?action=list"
                                   class="px-4 py-2 rounded-xl bg-slate-200 text-slate-700 text-sm font-medium
                                   hover:bg-slate-300 transition">
                                    ← Quay lại
                                </a>

                                <button type="submit"
                                        class="px-5 py-2 rounded-xl bg-brand-600 text-white text-sm font-semibold
                                        shadow-soft hover:bg-brand-700 transition">
                                    Cập nhật
                                </button>
                            </div>
                        </form>
                    </c:when>

                    <c:otherwise>
                        <div class="p-3 bg-red-50 border border-red-200 text-red-700 rounded-xl text-sm mb-4 text-center shadow-soft">
                            Không có dữ liệu để chỉnh sửa.
                        </div>
                        <div class="text-center">
                            <a href="StationServlet?action=list"
                               class="text-brand-600 hover:text-brand-800 hover:underline text-sm transition">
                                ← Quay lại
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
        </main>
    </jsp:body>
</ui:layout>

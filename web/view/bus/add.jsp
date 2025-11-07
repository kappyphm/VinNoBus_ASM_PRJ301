<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>

<ui:layout>
    <jsp:attribute name="title">Thêm Xe Bus Mới • VinNoBus</jsp:attribute>

    <jsp:body>
        <main class="min-h-screen flex items-center justify-center px-5 py-10">

            <div class="w-full max-w-md bg-white border border-slate-200 rounded-2xl shadow-soft p-6">

                <h1 class="text-xl font-semibold mb-1">Thêm Xe Bus Mới</h1>
                <p class="text-sm text-slate-600 mb-4">Nhập thông tin xe bus vào hệ thống VinNoBus.</p>

                <!-- Thông báo -->
                <c:if test="${not empty message}">
                    <div class="p-3 rounded-xl bg-green-50 border border-green-200 text-green-700 shadow-soft mb-3">
                        ✅ ${message}
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="p-3 rounded-xl bg-red-50 border border-red-200 text-red-700 shadow-soft mb-3">
                        ⚠️ ${error}
                    </div>
                </c:if>

                <form action="BusServlet" method="post" class="space-y-4">
                    <input type="hidden" name="action" value="add"/>

                    <!-- Plate -->
                    <div>
                        <label class="block text-sm font-medium mb-1">Biển số xe</label>
                        <input type="text" name="plate_number" placeholder="VD: 29B-123.45"
                               class="w-full px-3 py-2 rounded-xl border border-slate-300 bg-white focus:ring-2 focus:ring-brand-500 outline-none"/>
                    </div>

                    <!-- Capacity -->
                    <div>
                        <label class="block text-sm font-medium mb-1">Sức chứa</label>
                        <input type="number" name="capacity" placeholder="VD: 40"
                               class="w-full px-3 py-2 rounded-xl border border-slate-300 bg-white focus:ring-2 focus:ring-brand-500 outline-none"/>
                    </div>

                    <!-- Status -->
                    <div>
                        <label class="block text-sm font-medium mb-1">Trạng thái</label>
                        <select name="current_status"
                                class="w-full px-3 py-2 rounded-xl border border-slate-300 bg-white focus:ring-2 focus:ring-brand-500 outline-none">
                            <option value="AVAILABLE">AVAILABLE</option>
                            <option value="IN_USE">IN_USE</option>
                            <option value="MAINTENANCE">MAINTENANCE</option>
                            <option value="BROKEN">BROKEN</option>
                            <option value="REPAIRING">REPAIRING</option>
                            <option value="RESERVED">RESERVED</option>
                        </select>
                    </div>

                    <button type="submit"
                            class="w-full py-2.5 rounded-xl bg-brand-600 text-white text-sm font-medium shadow-soft hover:bg-brand-700 transition">
                        ➕ Thêm Xe Bus
                    </button>

                    <a href="BusServlet?action=list"
                       class="block text-center text-slate-600 text-sm hover:text-brand-700 hover:underline">
                        ← Quay lại danh sách
                    </a>
                </form>
            </div>

        </main>
    </jsp:body>
</ui:layout>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>

<ui:layout>
    <jsp:attribute name="title">Thêm trạm mới • VinNoBus</jsp:attribute>

    <jsp:body>
        <main class="flex items-center justify-center min-h-screen p-6 bg-brand-50">
            <div class="w-full max-w-md bg-white border border-slate-200 rounded-2xl shadow-soft p-8 animate-fadeIn">

                <h1 class="text-xl font-semibold text-center mb-1">Thêm trạm mới</h1>
                <p class="text-sm text-slate-600 text-center mb-5">
                    Tạo trạm mới trong hệ thống VinNoBus.
                </p>

                <!-- Thông báo lỗi -->
                <c:if test="${not empty error}">
                    <div class="p-3 rounded-xl bg-red-50 border border-red-200 text-red-700 text-sm shadow-soft mb-4">
                        ⚠️ ${error}
                    </div>
                </c:if>

                <!-- Form nhập liệu -->
                <form action="StationServlet" method="post" class="space-y-4">
                    <input type="hidden" name="action" value="create"/>

                    <!-- Tên trạm -->
                    <div>
                        <label class="text-sm font-medium mb-1 block">Tên trạm</label>
                        <input type="text"
                               name="stationName"
                               required
                               class="w-full px-3 py-2 rounded-xl bg-white border border-slate-300 text-sm
                               focus:ring-2 focus:ring-brand-500 outline-none">
                    </div>

                    <!-- Vị trí -->
                    <div>
                        <label class="text-sm font-medium mb-1 block">Vị trí</label>
                        <input type="text"
                               name="location"
                               required
                               class="w-full px-3 py-2 rounded-xl bg-white border border-slate-300 text-sm
                               focus:ring-2 focus:ring-brand-500 outline-none">
                    </div>

                    <!-- Buttons -->
                    <div class="flex justify-between items-center pt-2">
                        <a href="StationServlet?action=list"
                           class="text-sm text-slate-600 hover:text-brand-700 hover:underline transition">
                            ← Quay lại
                        </a>

                        <button type="submit"
                                class="px-6 py-2 rounded-xl bg-brand-600 text-white text-sm font-medium shadow-soft
                                hover:bg-brand-700 transition">
                            ➕ Thêm trạm
                        </button>
                    </div>
                </form>

            </div>
        </main>
    </jsp:body>
</ui:layout>

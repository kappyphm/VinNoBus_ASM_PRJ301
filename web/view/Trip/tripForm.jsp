<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>

<ui:layout>
    <jsp:attribute name="title">Thêm Chuyến xe mới • VinNoBus</jsp:attribute>

    <jsp:body>
        <main class="min-h-screen bg-brand-50 flex items-center justify-center p-6">
            <div class="w-full max-w-md bg-white rounded-2xl shadow-soft p-6">

                <h1 class="text-xl font-semibold mb-2 text-slate-900">Thêm chuyến xe mới</h1>
                <p class="text-sm text-slate-600 mb-4">Nhập thông tin chuyến xe vào hệ thống VinNoBus.</p>

                <!-- Hiển thị lỗi -->
                <c:if test="${not empty errors}">
                    <div class="mb-4 p-3 rounded-xl bg-red-50 border border-red-200 text-red-700 shadow-soft">
                        <ul class="list-disc pl-5">
                            <c:forEach var="err" items="${errors}">
                                <li>${err}</li>
                                </c:forEach>
                        </ul>
                    </div>
                </c:if>

                <!-- Thông báo thành công -->
                <c:if test="${not empty success}">
                    <div class="mb-4 p-3 rounded-xl bg-green-50 border border-green-200 text-green-700 shadow-soft">
                        ✅ ${success}
                    </div>
                </c:if>

                <form action="TripServlet?action=add" method="post" class="space-y-4">

                    <div>
                        <label class="block text-sm font-medium mb-1">Mã tuyến xe</label>
                        <input type="number" name="routeId" required
                               value="${param.routeId}"
                               class="w-full px-3 py-2 rounded-xl border border-slate-300 focus:ring-2 focus:ring-brand-500 outline-none">
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-1">Mã xe buýt</label>
                        <input type="number" name="busId" required
                               value="${param.busId}"
                               class="w-full px-3 py-2 rounded-xl border border-slate-300 focus:ring-2 focus:ring-brand-500 outline-none">
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-1">Tài xế</label>
                        <select name="driverId"
                                class="w-full px-3 py-2 rounded-xl border border-slate-300 focus:ring-2 focus:ring-brand-500 outline-none">
                            <option value="">-- Chọn tài xế --</option>
                            <c:forEach var="op" items="${operators}">
                                <option value="${op.userId}">${op.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-1">Phụ xe</label>
                        <select name="conductorId"
                                class="w-full px-3 py-2 rounded-xl border border-slate-300 focus:ring-2 focus:ring-brand-500 outline-none">
                            <option value="">-- Chọn phụ xe --</option>
                            <c:forEach var="op" items="${operators}">
                                <option value="${op.userId}">${op.name}</option>
                            </c:forEach>
                        </select>
                    </div>


                    <div>
                        <label class="block text-sm font-medium mb-1">Giờ khởi hành</label>
                        <input type="datetime-local" name="departureTime"
                               value="${param.departureTime}"
                               class="w-full px-3 py-2 rounded-xl border border-slate-300 focus:ring-2 focus:ring-brand-500 outline-none">
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-1">Giờ kết thúc</label>
                        <input type="datetime-local" name="arrivalTime"
                               value="${param.arrivalTime}"
                               class="w-full px-3 py-2 rounded-xl border border-slate-300 focus:ring-2 focus:ring-brand-500 outline-none">
                    </div>

                    <div class="flex justify-between items-center pt-3">
                        <a href="TripServlet?action=list"
                           class="px-4 py-2 rounded-xl border border-slate-300 text-sm text-slate-700 hover:bg-slate-100">
                            ← Quay lại danh sách
                        </a>

                        <button type="submit"
                                class="px-4 py-2 rounded-xl bg-brand-600 text-white text-sm font-medium hover:bg-brand-700 shadow-soft transition">
                            Thêm chuyến
                        </button>
                    </div>

                </form>
            </div>
        </main>
    </jsp:body>
</ui:layout>

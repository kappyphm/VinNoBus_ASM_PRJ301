<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>

<ui:layout>
    <jsp:attribute name="title">Chỉnh sửa Chuyến xe • VinNoBus</jsp:attribute>

    <jsp:body>
        <main class="min-h-screen bg-brand-50 flex items-center justify-center p-6">
            <div class="w-full max-w-md bg-white rounded-2xl shadow-soft p-6">

                <h1 class="text-xl font-semibold mb-2 text-slate-900">Chỉnh sửa chuyến xe</h1>
                <p class="text-sm text-slate-600 mb-4">Cập nhật thông tin chuyến xe trong hệ thống VinNoBus.</p>

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

                <form action="TripServlet?action=update" method="post" class="space-y-4">
                    <input type="hidden" name="tripId" value="${trip.tripId}">

                    <div>
                        <label class="block text-sm font-medium mb-1">Mã tuyến</label>
                        <input type="number" name="routeId" value="${trip.routeId}" required
                               class="w-full px-3 py-2 rounded-xl border border-slate-300 focus:ring-2 focus:ring-brand-500 outline-none">
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-1">Mã xe buýt</label>
                        <input type="number" name="busId" value="${trip.busId}" required
                               class="w-full px-3 py-2 rounded-xl border border-slate-300 focus:ring-2 focus:ring-brand-500 outline-none">
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-1">Tài xế</label>
                        <input type="text" name="driverId" value="${trip.driverId}" placeholder="Nguyễn Văn A" required
                               class="w-full px-3 py-2 rounded-xl border border-slate-300 focus:ring-2 focus:ring-brand-500 outline-none">
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-1">Phụ xe</label>
                        <input type="text" name="conductorId" value="${trip.conductorId}" placeholder="Nguyễn Văn B" required
                               class="w-full px-3 py-2 rounded-xl border border-slate-300 focus:ring-2 focus:ring-brand-500 outline-none">
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-1">Giờ khởi hành</label>
                        <input type="datetime-local" name="departureTime" value="${trip.departureTime}"
                               class="w-full px-3 py-2 rounded-xl border border-slate-300 focus:ring-2 focus:ring-brand-500 outline-none">
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-1">Giờ kết thúc</label>
                        <input type="datetime-local" name="arrivalTime" value="${trip.arrivalTime}"
                               class="w-full px-3 py-2 rounded-xl border border-slate-300 focus:ring-2 focus:ring-brand-500 outline-none">
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-1">Trạng thái</label>
                        <select name="status" class="w-full px-3 py-2 rounded-xl border border-slate-300 focus:ring-2 focus:ring-brand-500 outline-none">
                            <option value="NOT_STARTED" ${trip.status eq 'NOT_STARTED' ? 'selected' : ''}>Chưa bắt đầu</option>
                            <option value="IN_PROGRESS" ${trip.status eq 'IN_PROGRESS' ? 'selected' : ''}>Đang chạy</option>
                            <option value="COMPLETED" ${trip.status eq 'COMPLETED' ? 'selected' : ''}>Hoàn thành</option>
                            <option value="CANCELLED" ${trip.status eq 'CANCELLED' ? 'selected' : ''}>Đã hủy</option>
                        </select>
                    </div>

                    <div class="flex justify-between items-center pt-3">
                        <a href="TripServlet?action=list"
                           class="px-4 py-2 rounded-xl border border-slate-300 text-sm text-slate-700 hover:bg-slate-100 transition">
                            ← Quay lại
                        </a>

                        <div class="flex gap-2">
                            <button type="submit"
                                    class="px-4 py-2 rounded-xl bg-brand-600 text-white text-sm font-medium hover:bg-brand-700 shadow-soft transition">
                                Cập nhật
                            </button>

                            <a href="TripServlet?action=delete&tripId=${trip.tripId}" 
                               onclick="return confirm('Bạn chắc muốn xóa chuyến này?')"
                               class="px-4 py-2 rounded-xl bg-red-600 text-white text-sm font-medium hover:bg-red-700 shadow-soft transition">
                                Xóa
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </main>
    </jsp:body>
</ui:layout>

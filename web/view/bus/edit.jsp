<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chỉnh sửa Xe Bus • VinNoBus</title>

        <!-- Font + Tailwind -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@400;500;600;700&display=swap" rel="stylesheet">

        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        fontFamily: {mono: ['Roboto Mono', 'ui-monospace']},
                        colors: {
                            brand: {
                                50: '#eff6ff', 100: '#dbeafe', 200: '#bfdbfe', 300: '#93c5fd',
                                400: '#60a5fa', 500: '#3b82f6', 600: '#2563eb', 700: '#1d4ed8',
                                800: '#1e40af', 900: '#1e3a8a'
                            }
                        },
                        boxShadow: {soft: "0 8px 24px rgba(2,6,23,.06)"}
                    }
                }
            }
        </script>

        <style>
            html {
                font-family: 'Roboto Mono', ui-monospace;
            }
        </style>
    </head>

    <body class="bg-brand-50 min-h-screen text-slate-800 flex items-center justify-center px-4">

        <div class="w-full max-w-md bg-white border border-slate-200 rounded-2xl shadow-soft p-6">

            <!-- Title -->
            <h1 class="text-xl font-semibold mb-2">Chỉnh sửa Xe Bus</h1>
            <p class="text-sm text-slate-600">Cập nhật thông tin xe bus trong hệ thống VinNoBus.</p>

            <!-- Messages -->
            <c:if test="${not empty message}">
                <div class="mt-4 p-3 rounded-xl bg-green-50 border border-green-200 text-green-700 shadow-soft">
                    ✅ ${message}
                </div>
            </c:if>

            <!-- Form -->
            <form action="BusServlet" method="post" class="mt-5 space-y-4">
                <input type="hidden" name="action" value="update" />
                <input type="hidden" name="bus_id"
                       value="${bus_id != null ? bus_id : bus.busId}" />

                <!-- Plate -->
                <div>
                    <label class="block text-sm mb-1 font-medium">Biển số xe</label>
                    <input type="text" name="plate_number"
                           value="${plate_number != null ? plate_number : bus.plateNumber}"
                           placeholder="VD: 29B-123.45"
                           class="w-full px-3 py-2 rounded-xl border border-slate-300 bg-white focus:ring-2 focus:ring-brand-500 outline-none">
                    <c:if test="${not empty error_plate}">
                        <div class="text-red-600 text-xs mt-1">${error_plate}</div>
                    </c:if>
                </div>

                <!-- Capacity -->
                <div>
                    <label class="block text-sm mb-1 font-medium">Sức chứa</label>
                    <input type="number" name="capacity"
                           value="${capacity != null ? capacity : bus.capacity}"
                           min="1"
                           class="w-full px-3 py-2 rounded-xl border border-slate-300 bg-white focus:ring-2 focus:ring-brand-500 outline-none">
                    <c:if test="${not empty error_capacity}">
                        <div class="text-red-600 text-xs mt-1">${error_capacity}</div>
                    </c:if>
                </div>

                <!-- Status -->
                <div>
                    <label class="block text-sm mb-1 font-medium">Trạng thái</label>
                    <select name="current_status"
                            class="w-full px-3 py-2 rounded-xl border border-slate-300 bg-white focus:ring-2 focus:ring-brand-500 outline-none">
                        <option value="AVAILABLE"   ${bus.currentStatus == 'AVAILABLE' ? 'selected' : ''}>AVAILABLE</option>
                        <option value="IN_USE"      ${bus.currentStatus == 'IN_USE' ? 'selected' : ''}>IN_USE</option>
                        <option value="MAINTENANCE" ${bus.currentStatus == 'MAINTENANCE' ? 'selected' : ''}>MAINTENANCE</option>
                        <option value="BROKEN"      ${bus.currentStatus == 'BROKEN' ? 'selected' : ''}>BROKEN</option>
                        <option value="REPAIRING"   ${bus.currentStatus == 'REPAIRING' ? 'selected' : ''}>REPAIRING</option>
                        <option value="RESERVED"    ${bus.currentStatus == 'RESERVED' ? 'selected' : ''}>RESERVED</option>
                    </select>
                </div>

                <c:if test="${not empty error_general}">
                    <div class="text-red-600 text-xs mt-1">${error_general}</div>
                </c:if>

                <!-- Buttons -->
                <div class="flex justify-between pt-3">
                    <a href="BusServlet?action=list"
                       class="px-4 py-2 rounded-xl border border-slate-300 bg-white text-sm hover:bg-slate-100">
                        ← Quay lại
                    </a>

                    <button type="submit"
                            class="px-4 py-2 rounded-xl bg-brand-600 text-white text-sm font-medium hover:bg-brand-700 shadow-soft">
                        Cập nhật
                    </button>
                </div>

            </form>
        </div>

    </body>
</html>

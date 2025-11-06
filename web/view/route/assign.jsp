<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Gán Trạm cho Tuyến • VinNoBus</title>

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

    <body class="bg-brand-50 min-h-screen p-8 text-slate-800">

        <div class="max-w-6xl mx-auto bg-white p-8 border border-slate-200 rounded-2xl shadow-soft">

            <h1 class="text-2xl font-semibold">
                Gán trạm cho tuyến:
                <span class="text-brand-700">${route.routeName} (${route.type})</span>
            </h1>

            <!-- ✅ Lỗi -->
            <c:if test="${not empty errorMessage}">
                <div class="mt-4 p-4 rounded-xl bg-red-50 border border-red-200 text-red-700 shadow-soft">
                    ⚠️ ${errorMessage}
                </div>
            </c:if>

            <form action="RouteServlet" method="post" class="mt-6 space-y-6">
                <input type="hidden" name="action" value="saveAssignedStations">
                <input type="hidden" name="id" value="${route.routeId}">

                <!-- ✅ Bảng chọn trạm -->
                <div class="overflow-x-auto bg-white border border-slate-200 rounded-2xl shadow-soft">
                    <table class="min-w-full text-sm">
                        <thead class="border-b border-slate-200 text-slate-500">
                            <tr>
                                <th class="py-2 px-4 text-left">Chọn</th>
                                <th class="py-2 px-4 text-left">Tên trạm</th>
                                <th class="py-2 px-4 text-left">Thứ tự</th>
                                <th class="py-2 px-4 text-left">Thời gian (phút)</th>
                            </tr>
                        </thead>

                        <tbody class="divide-y divide-slate-100 bg-white">
                            <c:forEach var="station" items="${allStations}" varStatus="status">
                                <tr class="hover:bg-brand-50 transition">
                                    <!-- Checkbox -->
                                    <td class="py-2 px-4">
                                        <input type="checkbox"
                                               name="stationIds"
                                               value="${station.stationId}"
                                               class="w-5 h-5 text-brand-600 rounded border-slate-300 focus:ring-brand-500"
                                               data-index="${status.index}">
                                        <input type="hidden" name="index_of_${station.stationId}" value="${status.index}">
                                    </td>

                                    <!-- Tên trạm -->
                                    <td class="py-2 px-4 font-medium">${station.stationName}</td>

                                    <!-- Thứ tự -->
                                    <td class="py-2 px-4">
                                        <input type="number"
                                               name="stationOrder_${status.index}"
                                               min="1"
                                               class="w-20 px-2 py-1 rounded-lg border border-slate-300 text-sm focus:ring-2 focus:ring-brand-500 outline-none">
                                    </td>

                                    <!-- Thời gian -->
                                    <td class="py-2 px-4">
                                        <input type="number"
                                               name="estimatedTime_${status.index}"
                                               min="0"
                                               class="w-24 px-2 py-1 rounded-lg border border-slate-300 text-sm focus:ring-2 focus:ring-brand-500 outline-none">
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>

                    </table>
                </div>

                <!-- ✅ Buttons -->
                <div class="flex items-center gap-4 pt-3">
                    <button type="submit"
                            class="px-5 py-2 rounded-xl bg-brand-600 text-white text-sm font-medium shadow-soft hover:bg-brand-700 transition">
                        💾 Lưu danh sách trạm
                    </button>

                    <a href="RouteServlet?action=details&id=${route.routeId}"
                       class="text-sm text-slate-600 hover:text-brand-700 hover:underline transition">
                        ← Hủy / Quay lại chi tiết tuyến
                    </a>
                </div>

            </form>
        </div>

    </body>
</html>

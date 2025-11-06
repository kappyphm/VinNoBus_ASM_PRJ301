<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Cập nhật tuyến • VinNoBus</title>

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

    <body class="bg-brand-50 min-h-screen flex items-center justify-center px-5">

        <div class="w-full max-w-lg bg-white border border-slate-200 rounded-2xl shadow-soft p-6">

            <h1 class="text-xl font-semibold mb-1">Cập nhật tuyến xe buýt</h1>
            <p class="text-sm text-slate-600 mb-5">Chỉnh sửa thông tin tuyến trong hệ thống VinNoBus.</p>

            <!-- ✅ Thông báo thành công -->
            <c:if test="${not empty message}">
                <div class="p-3 rounded-xl bg-green-50 border border-green-200 text-green-700 shadow-soft mb-4">
                    ✅ ${message}
                </div>
            </c:if>

            <!-- ✅ Thông báo lỗi -->
            <c:if test="${not empty errorMessage}">
                <div class="p-3 rounded-xl bg-red-50 border border-red-200 text-red-700 shadow-soft mb-4">
                    ⚠️ ${errorMessage}
                </div>
            </c:if>

            <form action="RouteServlet?action=update" method="post" class="space-y-4">
                <input type="hidden" name="routeId" value="${route.routeId}"/>

                <!-- Tên tuyến -->
                <div>
                    <label class="block mb-1 text-sm font-medium">Tên tuyến</label>
                    <input type="text"
                           name="routeName"
                           value="${route.routeName}"
                           class="w-full px-3 py-2 rounded-xl border border-slate-300 bg-white text-sm focus:ring-2 focus:ring-brand-500 outline-none"/>
                </div>

                <!-- Loại tuyến -->
                <div>
                    <label class="block mb-1 text-sm font-medium">Loại tuyến</label>
                    <select name="type"
                            class="w-full px-3 py-2 rounded-xl border border-slate-300 bg-white text-sm focus:ring-2 focus:ring-brand-500 outline-none">
                        <option value="CIRCULAR"   ${route.type == 'CIRCULAR' ? 'selected' : ''}>CIRCULAR</option>
                        <option value="ROUND_TRIP" ${route.type == 'ROUND_TRIP' ? 'selected' : ''}>ROUND_TRIP</option>
                    </select>
                </div>

                <!-- Tần suất -->
                <div>
                    <label class="block mb-1 text-sm font-medium">Tần suất (phút)</label>
                    <input type="number"
                           name="frequency"
                           min="1"
                           value="${route.frequency}"
                           class="w-full px-3 py-2 rounded-xl border border-slate-300 bg-white text-sm focus:ring-2 focus:ring-brand-500 outline-none"/>
                </div>

                <!-- Buttons -->
                <div class="flex justify-between pt-3">
                    <a href="RouteServlet?action=list"
                       class="px-4 py-2 rounded-xl border border-slate-300 bg-white text-sm hover:bg-slate-100 transition">
                        ← Quay lại
                    </a>

                    <button type="submit"
                            class="px-5 py-2 rounded-xl bg-brand-600 text-white text-sm font-medium shadow-soft hover:bg-brand-700">
                        💾 Cập nhật
                    </button>
                </div>

            </form>
        </div>

    </body>
</html>

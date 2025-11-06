<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết tuyến đường • VinNoBus</title>

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

    <body class="bg-brand-50 min-h-screen flex items-center justify-center px-5 py-10 text-slate-800">

        <div class="w-full max-w-5xl bg-white border border-slate-200 rounded-2xl shadow-soft p-8">

            <h1 class="text-2xl font-semibold mb-1">Chi tiết tuyến đường</h1>
            <p class="text-sm text-slate-600 mb-6">Thông tin đầy đủ về tuyến bus trong hệ thống VinNoBus.</p>

            <!-- ===================== THÔNG TIN TUYẾN ===================== -->
            <div class="rounded-2xl border border-slate-200 overflow-hidden bg-white">
                <table class="min-w-full text-sm">

                    <tbody class="divide-y divide-slate-200">
                        <tr>
                            <td class="p-3 font-medium text-slate-600 w-1/3">Mã tuyến đường</td>
                            <td class="p-3">${route.routeId}</td>
                        </tr>

                        <tr>
                            <td class="p-3 font-medium text-slate-600">Tên tuyến đường</td>
                            <td class="p-3">${route.routeName}</td>
                        </tr>

                        <tr>
                            <td class="p-3 font-medium text-slate-600">Loại tuyến</td>
                            <td class="p-3">${route.type}</td>
                        </tr>

                        <tr>
                            <td class="p-3 font-medium text-slate-600">Tần suất</td>
                            <td class="p-3">${route.frequency} phút</td>
                        </tr>

                        <tr>
                            <td class="p-3 font-medium text-slate-600">Tổng thời gian dự kiến</td>
                            <td class="p-3">${route.estimatedTime} phút</td>
                        </tr>
                    </tbody>

                </table>
            </div>

            <!-- ===================== DANH SÁCH TRẠM ===================== -->
            <h2 class="text-xl font-semibold mt-10 mb-3">Danh sách trạm đi qua</h2>

            <c:choose>
                <c:when test="${not empty route.stations}">
                    <div class="rounded-2xl border border-slate-200 overflow-hidden bg-white">
                        <table class="min-w-full text-sm">
                            <thead>
                                <tr class="text-left text-slate-500 border-b border-slate-200">
                                    <th class="py-2 px-4">Thứ tự</th>
                                    <th class="py-2 px-4">Mã trạm</th>
                                    <th class="py-2 px-4">Tên trạm</th>
                                    <th class="py-2 px-4">Vị trí</th>
                                    <th class="py-2 px-4">Thời gian (phút)</th>
                                </tr>
                            </thead>

                            <tbody class="divide-y divide-slate-100">
                                <c:forEach var="s" items="${route.stations}">
                                    <tr class="hover:bg-brand-50 transition">
                                        <td class="py-2 px-4 text-center">${s.stationOrder}</td>
                                        <td class="py-2 px-4">${s.stationId}</td>
                                        <td class="py-2 px-4">${s.stationName}</td>
                                        <td class="py-2 px-4">${s.location}</td>
                                        <td class="py-2 px-4 text-center">${s.estimatedTime}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>

                        </table>
                    </div>
                </c:when>

                <c:otherwise>
                    <p class="text-sm text-slate-500 italic mt-3">
                        Chưa có trạm nào thuộc tuyến này.
                    </p>
                </c:otherwise>
            </c:choose>

            <!-- ===================== NÚT HÀNH ĐỘNG ===================== -->
            <div class="flex justify-center gap-4 mt-8">

                <a href="RouteServlet?action=list"
                   class="px-5 py-2 rounded-xl border border-slate-300 bg-white text-sm hover:bg-slate-100 transition">
                    ← Quay lại
                </a>

                <a href="RouteServlet?action=edit&id=${route.routeId}"
                   class="px-5 py-2 rounded-xl bg-yellow-600 text-white text-sm font-medium shadow-soft hover:bg-yellow-700 transition">
                    ✏️ Sửa
                </a>

                <a href="RouteServlet?action=delete&id=${route.routeId}"
                   onclick="return confirm('Bạn có chắc muốn xóa tuyến đường này không?');"
                   class="px-5 py-2 rounded-xl bg-red-600 text-white text-sm font-medium shadow-soft hover:bg-red-700 transition">
                    🗑 Xóa
                </a>

            </div>

        </div>

    </body>
</html>

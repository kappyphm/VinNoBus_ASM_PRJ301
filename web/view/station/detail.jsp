<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết trạm • VinNoBus</title>

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
            };
        </script>

        <style>
            html {
                font-family: 'Roboto Mono', ui-monospace;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }
                to   {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .animate-fadeIn {
                animation: fadeIn 0.35s ease-out;
            }
        </style>
    </head>

    <body class="bg-brand-50 min-h-screen flex items-center justify-center p-6">

        <div class="bg-white w-full max-w-lg p-8 border border-slate-200 rounded-2xl shadow-soft animate-fadeIn">

            <h1 class="text-xl font-semibold text-center mb-6">
                Chi tiết trạm
            </h1>

            <!-- ✅ Thông báo lỗi -->
            <c:if test="${not empty error}">
                <div class="p-3 bg-red-50 border border-red-200 text-red-700 rounded-xl text-sm mb-4 text-center shadow-soft">
                    ⚠️ ${error}
                </div>

                <div class="text-center">
                    <a href="StationServlet?action=list"
                       class="text-sm text-brand-600 hover:text-brand-800 hover:underline transition">
                        ← Quay lại danh sách
                    </a>
                </div>
            </c:if>

            <!-- ✅ Hiển thị thông tin trạm -->
            <c:if test="${not empty station}">
                <div class="divide-y divide-slate-200 text-sm">

                    <div class="py-3 flex justify-between">
                        <span class="font-medium text-slate-600">Mã trạm</span>
                        <span class="text-slate-800">${station.stationId}</span>
                    </div>

                    <div class="py-3 flex justify-between">
                        <span class="font-medium text-slate-600">Tên trạm</span>
                        <span class="text-slate-800">${station.stationName}</span>
                    </div>

                    <div class="py-3 flex justify-between">
                        <span class="font-medium text-slate-600">Vị trí</span>
                        <span class="text-slate-800">${station.location}</span>
                    </div>

                    <div class="py-3 flex justify-between items-start">
                        <span class="font-medium text-slate-600">Tuyến đi qua</span>
                        <span class="text-slate-800 text-right">
                            <c:choose>
                                <c:when test="${not empty station.routeNames}">
                                    <c:forEach var="name" items="${station.routeNames}" varStatus="loop">
                                        ${name}<c:if test="${!loop.last}">, </c:if>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>Không có</c:otherwise>
                            </c:choose>
                        </span>
                    </div>

                </div>

                <div class="text-center mt-8">
                    <a href="StationServlet?action=list"
                       class="px-5 py-2 rounded-xl bg-brand-600 text-white text-sm font-medium shadow-soft hover:bg-brand-700 transition">
                        ← Quay lại danh sách
                    </a>
                </div>
            </c:if>

            <!-- ✅ Không tìm thấy -->
            <c:if test="${empty station and empty error}">
                <div class="p-3 bg-red-50 border border-red-200 text-red-700 rounded-xl text-sm mb-4 text-center shadow-soft">
                    Không tìm thấy thông tin trạm.
                </div>

                <div class="text-center">
                    <a href="StationServlet?action=list"
                       class="text-sm text-brand-600 hover:text-brand-800 hover:underline transition">
                        ← Quay lại danh sách
                    </a>
                </div>
            </c:if>

        </div>

    </body>
</html>

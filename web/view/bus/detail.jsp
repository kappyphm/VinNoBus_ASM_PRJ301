<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết Xe Bus • VinNoBus</title>

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

    <body class="bg-brand-50 min-h-screen text-slate-800 flex items-center justify-center px-5">

        <div class="w-full max-w-lg bg-white border border-slate-200 rounded-2xl shadow-soft p-6">

            <h1 class="text-xl font-semibold mb-1">Chi tiết Xe Bus</h1>
            <p class="text-sm text-slate-600 mb-6">Thông tin đầy đủ về xe bus trong hệ thống VinNoBus.</p>

            <div class="space-y-4 text-sm">

                <!-- Bus ID -->
                <div class="flex justify-between border-b pb-2">
                    <span class="text-slate-500">Bus ID:</span>
                    <span class="font-medium">${bus.busId}</span>
                </div>

                <!-- Plate -->
                <div class="flex justify-between border-b pb-2">
                    <span class="text-slate-500">Biển số xe:</span>
                    <span class="font-medium">${bus.plateNumber}</span>
                </div>

                <!-- Capacity -->
                <div class="flex justify-between border-b pb-2">
                    <span class="text-slate-500">Sức chứa:</span>
                    <span>${bus.capacity} chỗ</span>
                </div>

                <!-- Status -->
                <div class="flex justify-between items-center">
                    <span class="text-slate-500">Trạng thái:</span>

                    <span class="
                          px-3 py-1 rounded-xl text-xs font-semibold text-white
                          <c:choose>
                              <c:when test='${bus.currentStatus == "AVAILABLE"}'>bg-green-600</c:when>
                              <c:when test='${bus.currentStatus == "IN_USE"}'>bg-blue-600</c:when>
                              <c:when test='${bus.currentStatus == "MAINTENANCE"}'>bg-yellow-600</c:when>
                              <c:when test='${bus.currentStatus == "BROKEN"}'>bg-red-600</c:when>
                              <c:when test='${bus.currentStatus == "REPAIRING"}'>bg-orange-600</c:when>
                              <c:when test='${bus.currentStatus == "RESERVED"}'>bg-purple-600</c:when>
                              <c:otherwise>bg-slate-500</c:otherwise>
                          </c:choose>
                          ">
                        ${bus.currentStatus}
                    </span>
                </div>
            </div>

            <!-- Back -->
            <div class="text-center mt-8">
                <a href="BusServlet?action=list"
                   class="inline-block px-5 py-2 rounded-xl bg-brand-600 text-white text-sm font-medium shadow-soft hover:bg-brand-700 transition">
                    ← Quay lại danh sách
                </a>
            </div>

        </div>

    </body>
</html>

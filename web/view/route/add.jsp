<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thêm Tuyến Mới • VinNoBus</title>

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
            @keyframes fadeSlideUp {
                from {
                    opacity: 0;
                    transform: translateY(15px);
                }
                to   {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .fadeSlideUp {
                animation: fadeSlideUp 0.5s ease-out;
            }
        </style>
    </head>

    <body class="bg-brand-50 min-h-screen flex items-center justify-center px-5">

        <div class="w-full max-w-xl bg-white border border-slate-200 rounded-2xl shadow-soft p-8 fadeSlideUp">

            <h1 class="text-xl font-semibold text-center">➕ Thêm tuyến mới</h1>
            <p class="text-sm text-slate-600 text-center mb-6">
                Tạo tuyến xe buýt mới trong hệ thống VinNoBus.
            </p>

            <!-- ✅ Thông báo thành công -->
            <c:if test="${not empty sessionScope.message}">
                <div class="p-4 rounded-xl bg-green-50 border border-green-200 text-green-700 shadow-soft text-sm mb-4">
                    ✅ ${sessionScope.message}
                </div>
            </c:if>
            <c:remove var="message" scope="session"/>

            <!-- ✅ Thông báo lỗi -->
            <c:if test="${not empty requestScope.errorMessage}">
                <div class="p-4 rounded-xl bg-red-50 border border-red-200 text-red-700 shadow-soft text-sm mb-4">
                    ⚠️ ${requestScope.errorMessage}
                </div>
            </c:if>

            <!-- ✅ Form thêm tuyến -->
            <form action="RouteServlet?action=add" method="post" class="space-y-4">

                <!-- Tên tuyến -->
                <div>
                    <label class="text-sm font-medium mb-1 block">Tên tuyến</label>
                    <input type="text"
                           name="routeName"
                           required
                           class="w-full px-3 py-2 rounded-xl bg-white border border-slate-300 text-sm
                           focus:ring-2 focus:ring-brand-500 outline-none">
                </div>

                <!-- Loại tuyến -->
                <div>
                    <label class="text-sm font-medium mb-1 block">Loại tuyến</label>
                    <select name="type"
                            required
                            class="w-full px-3 py-2 rounded-xl bg-white border border-slate-300 text-sm
                            focus:ring-2 focus:ring-brand-500 outline-none">
                        <option value="">-- Chọn loại --</option>
                        <option value="CIRCULAR">CIRCULAR</option>
                        <option value="ROUND_TRIP">ROUND_TRIP</option>
                    </select>
                </div>

                <!-- Tần suất -->
                <div>
                    <label class="text-sm font-medium mb-1 block">Tần suất (phút/chuyến)</label>
                    <input type="number"
                           name="frequency"
                           min="1"
                           required
                           class="w-full px-3 py-2 rounded-xl bg-white border border-slate-300 text-sm
                           focus:ring-2 focus:ring-brand-500 outline-none">
                </div>

                <!-- ✅ Buttons -->
                <div class="flex justify-between items-center pt-2">

                    <a href="RouteServlet?action=list"
                       class="text-sm text-slate-600 hover:text-brand-700 hover:underline transition">
                        ← Quay lại danh sách
                    </a>

                    <button type="submit"
                            class="px-6 py-2 rounded-xl bg-brand-600 text-white text-sm font-medium shadow-soft
                            hover:bg-brand-700 transition">
                        ➕ Thêm tuyến
                    </button>

                </div>

            </form>
        </div>

    </body>
</html>

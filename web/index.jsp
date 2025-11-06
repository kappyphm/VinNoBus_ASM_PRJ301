<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>VinNoBus • Trang chủ</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@400;500;600;700&display=swap" rel="stylesheet">
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        fontFamily: {mono: ['Roboto Mono', 'ui-monospace', 'SFMono-Regular']},
                        colors: {
                            brand: {50: '#eff6ff', 100: '#dbeafe', 200: '#bfdbfe', 300: '#93c5fd', 400: '#60a5fa', 500: '#3b82f6', 600: '#2563eb', 700: '#1d4ed8', 800: '#1e40af', 900: '#1e3a8a'}
                        },
                        boxShadow: {soft: '0 8px 24px rgba(2,6,23,.06)'}
                    }
                }
            }
        </script>
    </head>
    <body class="bg-brand-50 font-mono text-slate-800 min-h-screen flex flex-col">

        <!-- Header -->
        <jsp:include page="/header.jsp" />

        <!-- Main content -->
        <main class="flex-grow max-w-6xl mx-auto px-5 py-10">
            <!-- Header dashboard -->
            <div class="mb-10 text-center">
                <h1 class="text-3xl font-bold text-brand-700 mb-2">Dashboard VinNoBus</h1>
                <p class="text-slate-600">Quản lý các tuyến xe, chuyến đi, trạm và báo cáo trong một giao diện gọn gàng.</p>
            </div>

            <!-- Dashboard cards -->
            <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-6">
                <!-- Xe Bus -->
                <a href="users" class="bg-white rounded-2xl shadow-soft p-6 flex flex-col items-center hover:shadow-lg hover:scale-[1.02] transition">
                    <div class="text-5xl mb-3 text-brand-500">😏</div>
                    <div class="font-semibold text-lg text-slate-800 mb-1">Quản lý Người dùng</div>
                    <p class="text-sm text-slate-500 text-center">Xem, thêm, chỉnh sửa và xóa thông tin Người dùng hệ thống.</p>
                </a>
                <!-- Xe Bus -->
                <a href="BusServlet?action=list" class="bg-white rounded-2xl shadow-soft p-6 flex flex-col items-center hover:shadow-lg hover:scale-[1.02] transition">
                    <div class="text-5xl mb-3 text-brand-500">🚍</div>
                    <div class="font-semibold text-lg text-slate-800 mb-1">Quản lý Xe Bus</div>
                    <p class="text-sm text-slate-500 text-center">Xem, thêm, chỉnh sửa và xóa thông tin các xe bus.</p>
                </a>

                <!-- Tuyến -->
                <a href="RouteServlet?action=list" class="bg-white rounded-2xl shadow-soft p-6 flex flex-col items-center hover:shadow-lg hover:scale-[1.02] transition">
                    <div class="text-5xl mb-3 text-brand-500">🛣️</div>
                    <div class="font-semibold text-lg text-slate-800 mb-1">Quản lý Tuyến</div>
                    <p class="text-sm text-slate-500 text-center">Tạo và quản lý các tuyến xe, cập nhật lộ trình dễ dàng.</p>
                </a>

                <!-- Chuyến -->
                <a href="TripServlet?action=list" class="bg-white rounded-2xl shadow-soft p-6 flex flex-col items-center hover:shadow-lg hover:scale-[1.02] transition">
                    <div class="text-5xl mb-3 text-brand-500">🕒</div>
                    <div class="font-semibold text-lg text-slate-800 mb-1">Quản lý Chuyến</div>
                    <p class="text-sm text-slate-500 text-center">Theo dõi, cập nhật và lập kế hoạch các chuyến đi.</p>
                </a>

                <!-- Trạm -->
                <a href="StationServlet?action=list" class="bg-white rounded-2xl shadow-soft p-6 flex flex-col items-center hover:shadow-lg hover:scale-[1.02] transition">
                    <div class="text-5xl mb-3 text-brand-500">🚏</div>
                    <div class="font-semibold text-lg text-slate-800 mb-1">Quản lý Trạm</div>
                    <p class="text-sm text-slate-500 text-center">Thêm, sửa, xóa các trạm dừng xe và quản lý vị trí.</p>
                </a>

                <!-- Báo cáo -->
                <a href="ReportServlet?action=overview" class="bg-white rounded-2xl shadow-soft p-6 flex flex-col items-center hover:shadow-lg hover:scale-[1.02] transition">
                    <div class="text-5xl mb-3 text-brand-500">📊</div>
                    <div class="font-semibold text-lg text-slate-800 mb-1">Báo cáo</div>
                    <p class="text-sm text-slate-500 text-center">Xem thống kê tổng quan, hiệu suất và KPI của hệ thống.</p>
                </a>
            </div>
        </main>


        <jsp:include page="/footer.jsp" />
    </body>
</html>

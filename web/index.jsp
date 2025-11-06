<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hệ thống Quản lý Tuyến Xe</title>

        <!-- Tailwind CDN -->
        <script src="https://cdn.tailwindcss.com"></script>
    </head>

    <body class="font-sans min-h-screen flex flex-col bg-gradient-to-br from-blue-100 to-blue-50 text-gray-800">

        <jsp:include page="/header.jsp" />

        <!-- MAIN -->
        <main class="text-center flex-grow py-24 px-4 animate-fadeUp">
            <h1 class="text-4xl font-bold text-blue-800 mb-4">
                Chào mừng đến với Hệ thống Quản lý Tuyến Xe
            </h1>
            <p class="text-lg text-gray-600">
                Chọn mục ở menu trên hoặc sử dụng các nút dưới đây để bắt đầu quản lý.
            </p>

            <!-- MENU BUTTONS -->
            <div class="mt-12 flex flex-wrap justify-center gap-5">
                <a href="BusServlet?action=list"
                   class="px-6 py-3 bg-gradient-to-r from-blue-800 to-blue-800 text-white rounded-xl shadow-md font-semibold hover:-translate-y-1 hover:shadow-xl transition">
                    🚍 Quản lý Xe Bus
                </a>

                <a href="RouteServlet?action=list"
                   class="px-6 py-3 bg-gradient-to-r from-blue-800 to-blue-800 text-white rounded-xl shadow-md font-semibold hover:-translate-y-1 hover:shadow-xl transition">
                    🛣️ Quản lý Tuyến
                </a>

                <a href="TripServlet?action=list"
                   class="px-6 py-3 bg-gradient-to-r from-blue-800 to-blue-800 text-white rounded-xl shadow-md font-semibold hover:-translate-y-1 hover:shadow-xl transition">
                    🕒 Quản lý Chuyến
                </a>

                <a href="StationServlet?action=list"
                   class="px-6 py-3 bg-gradient-to-r from-blue-800 to-blue-800 text-white rounded-xl shadow-md font-semibold hover:-translate-y-1 hover:shadow-xl transition">
                    🚏 Quản lý Trạm
                </a>

                <a href="TicketServlet?action=list"
                   class="px-6 py-3 bg-gradient-to-r from-blue-800 to-blue-800 text-white rounded-xl shadow-md font-semibold hover:-translate-y-1 hover:shadow-xl transition">
                    🎫 Quản lý Vé
                </a>

                <a href="RouteServlet?action=search"
                   class="px-6 py-3 bg-gradient-to-r from-blue-800 to-blue-800 text-white rounded-xl shadow-md font-semibold hover:-translate-y-1 hover:shadow-xl transition">
                    🔍 Tìm kiếm (Admin)
                </a>

                <a href="ReportServlet?action=overview"
                   class="px-6 py-3 bg-gradient-to-r from-blue-800 to-blue-800 text-white rounded-xl shadow-md font-semibold hover:-translate-y-1 hover:shadow-xl transition">
                    📊 Báo Cáo Tổng Hợp
                </a>
            </div>
        </main>

        <!-- FOOTER -->
        <footer class="mt-auto bg-gradient-to-br from-[#0d2b66] to-[#005fa3] text-white
                px-6 py-10 md:py-12 font-sans overflow-hidden animate-fadeUp">
            <div class="max-w-6xl mx-auto grid grid-cols-1 md:grid-cols-3 gap-10">

                <div>
                    <h3 class="text-2xl font-bold mb-2">Bus Management System</h3>
                    <p class="text-blue-200">Hệ thống quản lý tuyến xe thông minh và chuyên nghiệp</p>
                </div>

                <div>
                    <h4 class="text-xl font-semibold text-yellow-300 mb-2">Liên hệ</h4>
                    <p class="text-blue-200">📍 123 Đường ABC, TP.HCM</p>
                    <p class="text-blue-200">✉️ support@busmanagement.com</p>
                    <p class="text-blue-200">📞 +84 123 456 789</p>
                </div>

                <div>
                    <h4 class="text-xl font-semibold text-yellow-300 mb-2">Theo dõi chúng tôi</h4>
                    <div class="flex gap-3 mt-2">
                        <a href="#" class="w-10 h-10 flex items-center justify-center rounded-full bg-white/20 hover:bg-yellow-300 hover:text-blue-800 transition text-lg">🌐</a>
                        <a href="#" class="w-10 h-10 flex items-center justify-center rounded-full bg-white/20 hover:bg-yellow-300 hover:text-blue-800 transition text-lg">🐦</a>
                        <a href="#" class="w-10 h-10 flex items-center justify-center rounded-full bg-white/20 hover:bg-yellow-300 hover:text-blue-800 transition text-lg">📘</a>
                        <a href="#" class="w-10 h-10 flex items-center justify-center rounded-full bg-white/20 hover:bg-yellow-300 hover:text-blue-800 transition text-lg">💼</a>
                    </div>
                </div>
            </div>

            <div class="text-center text-blue-200 text-sm mt-6 border-t border-white/20 pt-4">
                © 2025 Bus Management System - Designed by Ngô Quang Huy, Phạm Gia Khánh,
                Nguyễn Thị Thắm, Đinh Thị Thu Trang, Nguyễn Bá Quang Minh
            </div>
        </footer>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        keyframes: {
                            fadeUp: {
                                '0%': {opacity: 0, transform: 'translateY(40px)'},
                                '100%': {opacity: 1, transform: 'translateY(0)'},
                            }
                        },
                        animation: {
                            fadeUp: 'fadeUp 1s ease forwards'
                        }
                    }
                }
            }
        </script>

    </body>
</html>

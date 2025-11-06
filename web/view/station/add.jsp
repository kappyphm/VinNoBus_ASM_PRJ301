<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thêm trạm mới • VinNoBus</title>

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
                animation: fadeIn 0.4s ease-out;
            }
        </style>
    </head>

    <body class="bg-brand-50 min-h-screen flex items-center justify-center p-6">

        <div class="w-full max-w-md bg-white border border-slate-200 rounded-2xl shadow-soft p-8 animate-fadeIn">

            <h1 class="text-xl font-semibold text-center mb-1">Thêm trạm mới</h1>
            <p class="text-sm text-slate-600 text-center mb-5">
                Tạo trạm mới trong hệ thống VinNoBus.
            </p>

            <!-- ✅ Thông báo lỗi -->
            <% if (request.getAttribute("error") != null) { %>
            <div class="p-3 rounded-xl bg-red-50 border border-red-200 text-red-700 text-sm shadow-soft mb-4">
                ⚠️ <%= request.getAttribute("error") %>
            </div>
            <% } %>

            <!-- ✅ Form nhập liệu -->
            <form action="StationServlet" method="post" class="space-y-4">
                <input type="hidden" name="action" value="create"/>

                <!-- Tên trạm -->
                <div>
                    <label class="text-sm font-medium mb-1 block">Tên trạm</label>
                    <input type="text"
                           name="stationName"
                           required
                           class="w-full px-3 py-2 rounded-xl bg-white border border-slate-300 text-sm
                           focus:ring-2 focus:ring-brand-500 outline-none">
                </div>

                <!-- Vị trí -->
                <div>
                    <label class="text-sm font-medium mb-1 block">Vị trí</label>
                    <input type="text"
                           name="location"
                           required
                           class="w-full px-3 py-2 rounded-xl bg-white border border-slate-300 text-sm
                           focus:ring-2 focus:ring-brand-500 outline-none">
                </div>

                <!-- Buttons -->
                <div class="flex justify-between items-center pt-2">
                    <a href="StationServlet?action=list"
                       class="text-sm text-slate-600 hover:text-brand-700 hover:underline transition">
                        ← Quay lại
                    </a>

                    <button type="submit"
                            class="px-6 py-2 rounded-xl bg-brand-600 text-white text-sm font-medium shadow-soft
                            hover:bg-brand-700 transition">
                        ➕ Thêm trạm
                    </button>
                </div>
            </form>

        </div>

    </body>
</html>

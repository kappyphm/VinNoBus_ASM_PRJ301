<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Cập nhật trạm • VinNoBus</title>

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

            <h2 class="text-xl font-semibold text-center mb-6">
                Cập nhật thông tin trạm
            </h2>

            <!-- Lỗi -->
            <c:if test="${not empty error}">
                <div class="p-3 bg-red-50 border border-red-200 text-red-700 rounded-xl text-sm mb-4 text-center shadow-soft">
                    ${error}
                </div>
            </c:if>

            <!-- Nội dung -->
            <c:choose>

                <c:when test="${not empty station}">
                    <form action="StationServlet" method="post" class="space-y-6">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="stationId" value="${station.stationId}">

                        <!-- Tên trạm -->
                        <div>
                            <label class="block text-sm mb-1 text-slate-600">Tên trạm</label>
                            <input type="text" name="stationName" value="${station.stationName}" required
                                   class="w-full px-3 py-2 rounded-xl border border-slate-300 bg-white
                                   focus:ring-2 focus:ring-brand-400 focus:border-brand-400 transition">
                        </div>

                        <!-- Vị trí -->
                        <div>
                            <label class="block text-sm mb-1 text-slate-600">Vị trí</label>
                            <input type="text" name="location" value="${station.location}" required
                                   class="w-full px-3 py-2 rounded-xl border border-slate-300 bg-white
                                   focus:ring-2 focus:ring-brand-400 focus:border-brand-400 transition">
                        </div>

                        <!-- Nút -->
                        <div class="flex justify-between mt-4">
                            <a href="StationServlet?action=list"
                               class="px-4 py-2 rounded-xl bg-slate-200 text-slate-700 text-sm font-medium
                               hover:bg-slate-300 transition">
                                ← Quay lại
                            </a>

                            <button type="submit"
                                    class="px-5 py-2 rounded-xl bg-brand-600 text-white text-sm font-semibold
                                    shadow-soft hover:bg-brand-700 transition">
                                Cập nhật
                            </button>
                        </div>
                    </form>
                </c:when>

                <c:otherwise>
                    <div class="p-3 bg-red-50 border border-red-200 text-red-700 rounded-xl text-sm mb-4 text-center shadow-soft">
                        Không có dữ liệu để chỉnh sửa.
                    </div>
                    <div class="text-center">
                        <a href="StationServlet?action=list"
                           class="text-brand-600 hover:text-brand-800 hover:underline text-sm transition">
                            ← Quay lại
                        </a>
                    </div>
                </c:otherwise>

            </c:choose>

        </div>

    </body>
</html>

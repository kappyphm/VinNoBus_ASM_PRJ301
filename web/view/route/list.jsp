<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/header.jsp" />

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách tuyến xe buýt • VinNoBus</title>

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

    <body class="bg-brand-50 min-h-screen text-slate-800">

        <main class="max-w-6xl mx-auto px-5 py-10">

            <h1 class="text-2xl font-semibold">Danh sách tuyến xe buýt</h1>
            <p class="text-sm text-slate-600 mt-1">Quản lý các tuyến bus trong hệ thống VinNoBus.</p>

            <!-- ✅ Thông báo -->
            <c:if test="${not empty sessionScope.message}">
                <div class="mt-4 p-4 rounded-xl bg-green-50 border border-green-200 text-green-700 shadow-soft">
                    ✅ ${sessionScope.message}
                </div>
                <c:remove var="message" scope="session"/>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="mt-4 p-4 rounded-xl bg-red-50 border border-red-200 text-red-700 shadow-soft">
                    ⚠️ ${errorMessage}
                </div>
                <c:remove var="errorMessage" scope="session"/>
            </c:if>

            <!-- ✅ Thanh công cụ -->
            <div class="flex flex-wrap items-center justify-between mt-6 gap-3">

                <!-- Add route -->
                <a href="RouteServlet?action=add"
                   class="px-4 py-2 rounded-xl bg-brand-600 text-white text-sm font-medium shadow-soft hover:bg-brand-700">
                    + Thêm tuyến
                </a>

                <!-- Search -->
                <form action="RouteServlet" method="get" class="flex items-center gap-2">
                    <input type="hidden" name="action" value="list">
                    <input type="text" name="search" value="${search}"
                           placeholder="Tìm theo tên..."
                           class="px-3 py-2 rounded-xl border border-slate-300 bg-white text-sm focus:ring-2 focus:ring-brand-500 outline-none">
                    <button type="submit"
                            class="px-4 py-2 rounded-xl bg-brand-600 text-white text-sm font-medium shadow-soft hover:bg-brand-700">
                        Tìm kiếm
                    </button>
                </form>
            </div>

            <!-- ✅ Bảng danh sách -->
            <div class="mt-6 bg-white border border-slate-200 rounded-2xl shadow-soft overflow-x-auto">
                <table class="min-w-full text-sm">
                    <thead>
                        <tr class="text-left text-slate-500 border-b border-slate-200">
                            <th class="py-2 px-4">ID</th>
                            <th class="py-2 px-4">Tên tuyến</th>
                            <th class="py-2 px-4">Loại tuyến</th>
                            <th class="py-2 px-4">Tần suất (phút)</th>
                            <th class="py-2 px-4">Hành động</th>
                        </tr>
                    </thead>

                    <tbody class="divide-y divide-slate-100">
                        <c:forEach var="r" items="${listRoutes}">
                            <tr class="hover:bg-brand-50 transition">
                                <td class="py-2 px-4 font-medium">${r.routeId}</td>
                                <td class="py-2 px-4">${r.routeName}</td>
                                <td class="py-2 px-4">${r.type}</td>
                                <td class="py-2 px-4">${r.frequency}</td>

                                <td class="py-2 px-4 flex flex-wrap gap-2">

                                    <a href="RouteServlet?action=details&id=${r.routeId}"
                                       class="px-3 py-1.5 rounded-lg bg-brand-600 text-white text-xs hover:bg-brand-700">
                                        📄 Chi tiết
                                    </a>

                                    <a href="RouteServlet?action=edit&id=${r.routeId}"
                                       class="px-3 py-1.5 rounded-lg bg-yellow-600 text-white text-xs hover:bg-yellow-700">
                                        ✏️ Sửa
                                    </a>

                                    <a href="RouteServlet?action=delete&id=${r.routeId}"
                                       onclick="return confirm('Bạn có chắc muốn xóa tuyến này không?');"
                                       class="px-3 py-1.5 rounded-lg bg-red-600 text-white text-xs hover:bg-red-700">
                                        🗑️ Xóa
                                    </a>

                                    <a href="RouteServlet?action=assign&id=${r.routeId}"
                                       class="px-3 py-1.5 rounded-lg bg-green-600 text-white text-xs hover:bg-green-700">
                                        🏁 Gán trạm
                                    </a>

                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>

                </table>
            </div>

            <!-- ✅ Phân trang -->
            <div class="mt-6 text-center">
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <span class="inline-block px-3 py-2 rounded-xl bg-brand-600 text-white shadow-soft mx-1 text-sm">
                                ${i}
                            </span>
                        </c:when>
                        <c:otherwise>
                            <a href="RouteServlet?action=list&page=${i}&search=${search}&type=${type}&sortColumn=${sortColumn}&sortOrder=${sortOrder}"
                               class="inline-block px-3 py-2 rounded-xl border border-brand-600 text-brand-600 hover:bg-brand-600 hover:text-white mx-1 text-sm transition">
                                ${i}
                            </a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>

        </main>

    </body>

    <jsp:include page="/footer.jsp" />
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Tìm tuyến xe • VinNoBus</title>

        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            // Cấu hình Tailwind để thêm các lớp tùy chỉnh (brand, shadow-soft) đã được sử dụng
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            brand: {
                                600: '#1A56DB', // Màu xanh dương (ví dụ)
                                700: '#1E429F'  // Màu xanh dương đậm hơn
                            }
                        },
                        boxShadow: {
                            // Mô phỏng lại shadow-soft
                            'soft': '0 4px 6px -1px rgb(0 0 0 / 0.05), 0 2px 4px -2px rgb(0 0 0 / 0.05)'
                        }
                    }
                }
            }
        </script>
    </head>
    <body class="bg-slate-50"> 
        <header class="border-b border-slate-200">
            <div class="max-w-6xl mx-auto px-5 py-4 flex items-center justify-between">
                <a href="/VinNoBus" class="flex items-center gap-2">
                    <div class="w-8 h-8 rounded-xl bg-brand-600 text-white grid place-items-center font-semibold">V</div>
                    <span class="font-semibold">VinNoBus</span>
                </a>
                <nav class="hidden sm:flex items-center gap-6 text-sm text-slate-600">
                    <a href="#cau-chuyen" class="hover:text-brand-700">Câu chuyện</a>
                    <a href="#gia-tri" class="hover:text-brand-700">Giá trị</a>
                    <a href="#hanh-trinh" class="hover:text-brand-700">Hành trình</a>
                    <a href="#lien-he" class="hover:text-brand-700">Liên hệ</a>
                </nav>
                <jsp:include page="/WEB-INF/components/LoginButton.jsp" />
            </div>

        </header>
        <main class="max-w-6xl mx-auto px-5 py-8">

            <h1 class="text-2xl font-semibold">Tìm tuyến xe đi qua 2 trạm</h1>
            <p class="text-sm text-slate-600 mt-1">Chọn hai trạm, hệ thống sẽ trả về các tuyến đi qua cả hai trạm đó.</p>

            <c:if test="${not empty param.errorMessage}">
                <div class="mt-4 p-4 rounded-xl bg-red-50 border border-red-200 text-red-700 shadow-soft">
                    ⚠️ <c:out value="${param.errorMessage}" />
                </div>
            </c:if>

            <c:if test="${empty stations}">
                <c:set var="stationsCsv" value="ST01|Bến xe Miền Đông;ST02|Bến xe Miền Tây;ST03|Suối Tiên;ST04|Vũng Tàu;ST05|Đà Lạt" />
                <c:set var="stations" value="${fn:split(stationsCsv,';')}" />
            </c:if>

            <form class="mt-6 grid grid-cols-1 md:grid-cols-[1fr_auto_1fr_auto] items-end gap-3 bg-white border border-slate-200 rounded-2xl p-4 shadow-soft"
                  action="${pageContext.request.contextPath}/RouteServlet" method="get">
                <input type="hidden" name="action" value="search">

                <div>
                    <label class="block text-sm mb-1">Trạm A</label>
                    <select name="a" required class="w-full rounded-xl border border-slate-200 px-3 py-2 bg-white">
                        <option value="">-- Chọn trạm --</option>
                        <c:forEach var="s" items="${stations}">
                            <option value="${s.stationId}" ${param.a == s.stationId ? 'selected' : ''}>${s.stationName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="hidden md:block text-center pb-3"> </div>

                <div>
                    <label class="block text-sm mb-1">Trạm B</label>
                    <select name="b" required class="w-full rounded-xl border border-slate-200 px-3 py-2 bg-white">
                        <option value="">-- Chọn trạm --</option>
                        <c:forEach var="s" items="${stations}">
                            <option value="${s.stationId}" ${param.b == s.stationId ? 'selected' : ''}>${s.stationName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div>
                    <button class="w-full md:w-auto mt-2 md:mt-0 px-4 py-2 rounded-xl bg-brand-600 text-white text-sm hover:bg-brand-700 shadow-soft">
                        Tìm tuyến
                    </button>
                </div>
            </form>

            <section class="mt-6">
                <c:choose>
                    <c:when test="${not empty routes and fn:length(routes) > 0}">
                        <div class="rounded-2xl border border-slate-200 bg-white shadow-soft">
                            <div class="p-4 border-b border-slate-200 flex items-center justify-between">
                                <h2 class="font-semibold">Kết quả</h2>
                                <div class="text-sm text-slate-500">Tuyến đi qua cả 2 trạm đã chọn</div>
                            </div>
                            <div class="p-4 overflow-x-auto">
                                <table class="min-w-full text-sm">
                                    <thead>
                                        <tr class="text-left text-slate-500">
                                            <th class="py-2 pr-4">Mã tuyến</th>
                                            <th class="py-2 pr-4">Tên tuyến</th>
                                            <th class="py-2 pr-4">Loại tuyến</th>
                                            <th class="py-2 pr-4">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-slate-100">
                                        <c:forEach var="r" items="${routes}">
                                            <tr>
                                                <td class="py-2 pr-4 font-medium">${r.routeId}</td>
                                                <td class="py-2 pr-4">${r.routeName}</td>
                                                <td class="py-2 pr-4">${r.type}</td>
                                                <td class="py-2 pr-4">
                                                    <a href="${pageContext.request.contextPath}/RouteServlet?action=details&id=${r.routeId}"
                                                       class="px-3 py-1 rounded-lg bg-green-600 text-white text-sm font-medium hover:bg-green-700 transition-colors">
                                                        Xem chi tiết
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="rounded-2xl border border-dashed border-slate-300 bg-white p-6 text-center text-slate-600">
                            Chưa có kết quả. Hãy chọn 2 trạm rồi bấm <strong>Tìm tuyến</strong>.
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>
        </main>

    </body>
</html>
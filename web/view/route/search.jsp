<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Tìm tuyến xe • VinNoBus</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-50 min-h-screen text-gray-800">

        <main class="max-w-6xl mx-auto px-5 py-8">
            <h1 class="text-2xl font-semibold mb-1">Tìm tuyến xe đi qua 2 trạm</h1>
            <p class="text-sm text-gray-600 mb-6">Chọn hai trạm, hệ thống sẽ trả về các tuyến đi qua cả hai trạm đó.</p>

            <form action="${pageContext.request.contextPath}/RouteServlet" method="get"
                  class="grid grid-cols-1 md:grid-cols-[1fr_auto_1fr_auto] gap-4 items-end bg-white border rounded-2xl p-6 shadow">
                <input type="hidden" name="action" value="search">

                <!-- Trạm A -->
                <div>
                    <label class="block text-sm mb-1 font-medium">Trạm A</label>
                    <select name="a" id="stationA" required
                            class="w-full border rounded-xl px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400">
                        <option value="">-- Chọn trạm --</option>
                        <c:forEach var="st" items="${stations}">
                            <option value="${st.stationId}" <c:if test="${st.stationId == selectedA}">selected</c:if>>
                                ${st.stationName}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="hidden md:block"></div>

                <!-- Trạm B -->
                <div>
                    <label class="block text-sm mb-1 font-medium">Trạm B</label>
                    <select name="b" id="stationB" required
                            class="w-full border rounded-xl px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400">
                        <option value="">-- Chọn trạm --</option>
                        <c:forEach var="st" items="${stations}">
                            <option value="${st.stationId}" <c:if test="${st.stationId == selectedB}">selected</c:if>>
                                ${st.stationName}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Button tìm -->
                <div>
                    <button type="submit"
                            class="px-6 py-2 rounded-xl bg-blue-600 text-white font-semibold shadow-md hover:bg-blue-700 transition-colors">
                        Tìm tuyến
                    </button>
                </div>
            </form>

            <!-- Kết quả -->
            <section class="mt-8">
                <c:choose>
                    <c:when test="${not empty routes}">
                        <div class="bg-white border rounded-2xl shadow p-4">
                            <div class="flex justify-between border-b pb-2 mb-2">
                                <h2 class="font-semibold">Kết quả</h2>
                                <span class="text-sm text-gray-500">Tuyến đi qua cả 2 trạm đã chọn</span>
                            </div>
                            <div class="overflow-x-auto">
                                <table class="min-w-full text-sm">
                                    <thead>
                                        <tr class="text-left text-gray-500">
                                            <th class="py-2 pr-4">Mã tuyến</th>
                                            <th class="py-2 pr-4">Tên tuyến</th>
                                            <th class="py-2 pr-4">Loại tuyến</th>
                                            <th class="py-2 pr-4">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-gray-100">
                                        <c:forEach var="route" items="${routes}">
                                            <tr>
                                                <td class="py-2 pr-4 font-medium">${route.routeId}</td>
                                                <td class="py-2 pr-4">${route.routeName}</td>
                                                <td class="py-2 pr-4">${route.type}</td>
                                                <td class="py-2 pr-4">
                                                    <a href="${pageContext.request.contextPath}/RouteServlet?action=details&routeId=${route.routeId}"
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
                        <div class="bg-white border-dashed border p-6 text-center text-gray-500 rounded-2xl">
                            Chưa có kết quả. Hãy chọn 2 trạm rồi bấm <strong>Tìm tuyến</strong>.
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>
        </main>
    </body>
</html>

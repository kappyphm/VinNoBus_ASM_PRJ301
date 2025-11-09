<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*, module.ticket.dao.TicketDAO" %>
<%@ page import="java.util.*, module.ticket.dao.TicketDAO" %>
<%
    // Chỉ load danh sách tuyến khi chưa tính tiền
    List<Map<String, Object>> routes = null;
    if (request.getParameter("action") == null) {
        TicketDAO dao = new TicketDAO();
        routes = dao.getAllRoutes();
        request.setAttribute("routes", routes);
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <title>Mua vé tháng • VinNoBus</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            brand: {
                                50: '#eff6ff',
                                100: '#dbeafe',
                                500: '#3b82f6',
                                600: '#2563eb',
                                700: '#1d4ed8'
                            }
                        },
                        boxShadow: {soft: '0 8px 24px rgba(2,6,23,.06)'}
                    }
                }
            }
        </script>
        <style>
            html {
                font-family: 'Roboto', sans-serif;
            }
        </style>
    </head>

    <body class="bg-brand-50 min-h-screen text-slate-800">
        <!-- Header -->
        <jsp:include page="/WEB-INF/components/header.jsp" />

        <!-- Main -->
        <main class="max-w-lg mx-auto p-6 mt-10 bg-white rounded-2xl shadow-soft">
            <h1 class="text-2xl font-semibold text-brand-700 text-center mb-6">Mua vé tháng</h1>

            <!-- Form tính tiền -->
            <form action="${pageContext.request.contextPath}/buy" method="post" class="space-y-4">
                <input type="hidden" name="action" value="calcMonth"/>

                <div>
                    <label class="block text-sm font-medium mb-1">ID khách hàng</label>
                    <input type="text" name="customerId" value="${sessionScope.user.userId}" readonly
                           class="w-full px-3 py-2 rounded-xl border border-slate-200 bg-slate-50 text-slate-600" />
                </div>

                <div>
                    <label class="block text-sm font-medium mb-1">Tuyến (vé ngày/tháng)</label>
                    <select name="routeId" required
                            class="w-full border border-slate-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-brand-300 focus:border-brand-500">
                        <option value="">-- Chọn tuyến --</option>
                        <c:forEach var="r" items="${routes}">
                            <option value="${r.route_id}">Tuyến ${r.route_id}: ${r.route_name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div>
                    <label class="block text-sm font-medium mb-1">Ngân hàng</label>
                    <input type="text" name="bank" value="MB Bank" readonly
                           class="w-full px-3 py-2 rounded-xl border border-slate-200 bg-gray-100 text-gray-700 cursor-not-allowed" />
                </div>

                <div>
                    <label class="block text-sm font-medium mb-1">Số tài khoản</label>
                    <input type="text" name="stk" value="0965047076" readonly
                           class="w-full px-3 py-2 rounded-xl border border-slate-200 bg-gray-100 text-gray-700 cursor-not-allowed" />
                </div>


                <button type="submit"
                        class="w-full py-3 bg-brand-600 text-white rounded-xl font-semibold hover:bg-brand-700 transition">
                    Tính tiền
                </button>
                           <a href="${pageContext.request.contextPath}/view/buy/ticket.jsp"
                   class="block w-full text-center bg-slate-400 hover:bg-slate-500 text-white py-2.5 rounded-xl font-medium transition-all shadow-soft">
                    ⬅️ Quay Lại
                </a>
            </form>

            <!-- Hóa đơn -->
            <c:if test="${not empty total}">
                <div class="mt-8 border-t border-slate-200 pt-6">
                    <h2 class="text-xl font-semibold text-brand-600 mb-3 text-center">Hóa đơn vé tháng</h2>
                    <div class="space-y-2 text-sm">
                        <p><b>Khách hàng:</b> ${customerId}</p>
                        <p><b>Tuyến:</b> ${routeId}</p>
                        <p><b>Giá vé:</b> ${price} VND</p>
                        <p><b>Tổng tiền:</b>
                            <span class="text-red-600 font-bold">${total} VND</span>
                        </p>
                    </div>

                    <img src="${qr}" alt="QR thanh toán"
                         class="mx-auto mt-4 w-64 rounded-xl border border-slate-200 shadow-soft" />

                    <form action="${pageContext.request.contextPath}/buy" method="post" class="mt-5">
                        <input type="hidden" name="action" value="buyMonth" />
                        <input type="hidden" name="customerId" value="${customerId}" />
                        <input type="hidden" name="routeId" value="${routeId}" />
                        <button type="submit"
                                class="w-full py-3 bg-green-600 text-white rounded-xl font-semibold hover:bg-green-700 transition">
                            Xác nhận đã chuyển khoản
                        </button>
                    </form>
                </div>
            </c:if>

            <!-- Thông báo -->
            <c:if test="${not empty message}">
                <p class="mt-6 text-center text-green-600 font-semibold">${message}</p>
            </c:if>
            <c:if test="${not empty error}">
                <p class="mt-6 text-center text-red-600 font-semibold">${error}</p>
            </c:if>

        </main>
    </body>
</html>

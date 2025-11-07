<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*, module.ticket.dao.TicketDAO" %>

<%
    TicketDAO dao = new TicketDAO();
    List<Map<String, Object>> routes = dao.getAllRoutes();
    request.setAttribute("routes", routes);
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Bán Vé & Thanh Toán VietQR • VinNoBus</title>

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;600;700&display=swap" rel="stylesheet">
        <script src="https://cdn.tailwindcss.com"></script>

        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        fontFamily: {mono: ['JetBrains Mono', 'ui-monospace', 'SFMono-Regular']},
                        colors: {
                            brand: {50: '#eff6ff', 100: '#dbeafe', 200: '#bfdbfe', 300: '#93c5fd', 400: '#60a5fa', 500: '#3b82f6', 600: '#2563eb', 700: '#1d4ed8', 800: '#1e40af', 900: '#1e3a8a'},
                        },
                        boxShadow: {soft: '0 8px 24px rgba(2,6,23,.06)'}
                    }
                }
            }
        </script>

        <style>
            html {
                font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,Monaco,Consolas,'Courier New',monospace
            }
        </style>
    </head>

    <body class="bg-brand-50 min-h-screen flex items-center justify-center p-6 text-slate-800">

        <div class="bg-white rounded-2xl shadow-soft p-8 w-full max-w-6xl border border-slate-200 flex flex-col md:flex-row gap-10">

            <!-- Form bán vé -->
            <form action="${pageContext.request.contextPath}/TicketServlet" method="post" class="flex-1 space-y-4">
                <input type="hidden" name="action" value="sell">

                <div class="flex items-center justify-center mb-4">
                    <div class="w-12 h-12 rounded-xl bg-brand-600 text-white grid place-items-center text-2xl shadow-soft">🎟️</div>
                </div>
                <h1 class="text-xl font-semibold text-center text-brand-700 mb-6">Bán Vé Xe Buýt</h1>

                <div>
                    <label class="block text-sm font-medium mb-1">Người tạo (ID)</label>
                    <input type="text" name="createdBy" value="${param.createdBy}" required
                           class="w-full border border-slate-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-brand-300 focus:border-brand-500">
                </div>

                <div>
                    <label class="block text-sm font-medium mb-1">ID Khách hàng</label>
                    <input type="text" name="customerId" value="${param.customerId}" required
                           class="w-full border border-slate-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-brand-300 focus:border-brand-500">
                </div>

                <div>
                    <label class="block text-sm font-medium mb-1">Loại vé</label>
                    <select name="ticketType" required
                            class="w-full border border-slate-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-brand-300 focus:border-brand-500">
                        <option value="TRIP" <c:if test="${param.ticketType=='TRIP'}">selected</c:if>>Vé lượt</option>
                        <option value="DAY" <c:if test="${param.ticketType=='DAY'}">selected</c:if>>Vé ngày</option>
                        <option value="MONTH" <c:if test="${param.ticketType=='MONTH'}">selected</c:if>>Vé tháng</option>
                        </select>
                    </div>

                <c:if test="${param.ticketType == 'TRIP' || empty param.ticketType}">
                    <div>
                        <label class="block text-sm font-medium mb-1">ID Chuyến (vé lượt)</label>
                        <input type="number" name="tripId" 
                               value="${param.tripId} required" 
                               class="w-full border border-slate-300 rounded-lg px-3 py-2"
                               placeholder="Nhập ID chuyến ">
                    </div>
                </c:if>
                <c:if test="${param.ticketType != 'TRIP' && not empty param.ticketType}">
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
                </c:if>
                <div>
                    <label class="block text-sm font-medium mb-1">Giá vé (VNĐ)</label>
                    <input type="number" step="0.01" name="price" value="${param.price}" required
                           class="w-full border border-slate-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-brand-300 focus:border-brand-500">
                </div>

                <div>
                    <label class="block text-sm font-medium mb-1">Hình thức thanh toán</label>
                    <select name="paymentMethod" required
                            class="w-full border border-slate-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-brand-300 focus:border-brand-500">
                        <option value="CASH" <c:if test="${param.paymentMethod=='CASH'}">selected</c:if>>Tiền mặt</option>
                        <option value="ONLINE" <c:if test="${param.paymentMethod=='ONLINE'}">selected</c:if>>Online</option>
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
                            class="w-full bg-brand-600 hover:bg-brand-700 text-white py-2.5 rounded-xl font-medium transition-all shadow-soft">
                        💰 Bán Vé
                    </button>

                    <a href="${pageContext.request.contextPath}/view/Ticket/main.jsp"
                   class="block w-full text-center bg-slate-400 hover:bg-slate-500 text-white py-2.5 rounded-xl font-medium transition-all shadow-soft">
                    ⬅️ Quay Lại
                </a>

                <c:if test="${not empty error}">
                    <div class="mt-4 bg-red-50 border-l-4 border-red-600 rounded-xl p-4 text-sm text-red-700 font-medium shadow-soft">
                        ❌ ${error}
                    </div>
                </c:if>

                <c:if test="${not empty message}">
                    <div class="mt-4 bg-brand-50 border-l-4 border-brand-600 rounded-xl p-4 text-sm text-brand-700 font-medium shadow-soft">
                        ✅ ${message}
                    </div>
                </c:if>

                <c:if test="${not empty quantity}">
                    <p class="text-sm mt-2"><b>Số lượng:</b> ${quantity} vé</p>
                </c:if>

                <c:if test="${not empty amount}">
                    <p class="text-sm"><b>Tổng tiền:</b> ${amount} VNĐ</p>
                </c:if>
            </form>

            <!-- QR hiển thị -->
            <div class="flex-1 text-center border-t md:border-t-0 md:border-l border-slate-200 pt-6 md:pt-0 md:pl-10">
                <c:if test="${param.paymentMethod=='ONLINE' && not empty param.amount && not empty param.stk && not empty param.bank}">
                    <h2 class="text-lg font-semibold text-brand-700 mb-4">Mã QR Thanh Toán</h2>
                    <p class="text-sm"><b>Ngân hàng:</b> ${param.bank}</p>
                    <p class="text-sm"><b>Số tài khoản:</b> ${param.stk}</p>
                    <p class="text-sm mb-3"><b>Số tiền:</b> ${param.amount} VNĐ</p>
                    <c:set var="qrUrl" value="https://img.vietqr.io/image/${param.bank}-${param.stk}-compact2.jpg?amount=${param.amount}&addInfo=Thanh+toan+ve+xe"/>
                    <img src="${qrUrl}" alt="QR Thanh toán" class="mx-auto w-64 rounded-lg border border-slate-300 shadow-soft">
                </c:if>

                <c:if test="${param.paymentMethod=='CASH'}">
                    <h2 class="text-lg font-semibold text-brand-700 mb-3">Thanh toán tiền mặt</h2>
                    <p class="text-sm text-slate-600">Khách hàng vui lòng thanh toán trực tiếp bằng tiền mặt.</p>
                </c:if>

                <c:if test="${not empty qr}">
                    <h2 class="text-lg font-semibold text-brand-700 mb-4">Mã QR Thanh Toán</h2>
                    <p><b>Ngân hàng:</b> ${bank}</p>
                    <p><b>Số tài khoản:</b> ${stk}</p>
                    <p><b>Số tiền:</b> ${amount} VNĐ</p>
                    <img src="${qr}" alt="QR Code Thanh toán" class="mx-auto w-64 rounded-lg border border-slate-300 shadow-soft">
                </c:if>
            </div>
        </div>

    </body>
</html>

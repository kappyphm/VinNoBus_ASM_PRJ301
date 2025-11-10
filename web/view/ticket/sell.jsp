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
    <title>Bán Vé • VinNoBus</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body, input, select, button {
            font-family: 'Roboto', sans-serif;
        }
    </style>
</head>
<body class="bg-blue-50 min-h-screen flex items-center justify-center text-slate-800">
    <div class="bg-white rounded-2xl shadow-soft p-6 w-full max-w-md border border-slate-200">
        <div class="flex flex-col items-center mb-5">
            <div class="w-9 h-9 rounded-lg bg-blue-600 text-white grid place-items-center text-lg shadow-soft">🎟️</div>
            <h1 class="text-lg font-semibold text-blue-700 mt-2">Bán Vé Xe Buýt</h1>
        </div>

        <!-- CHỌN LOẠI VÉ -->
        <form action="${pageContext.request.contextPath}/view/ticket/sell.jsp" method="get" class="mb-4">
            <label class="block text-sm font-medium mb-1">Loại vé</label>
            <select name="ticketType" onchange="this.form.submit()"
                    class="w-full border border-slate-300 rounded-md px-2 py-2 text-sm focus:ring-1 focus:ring-blue-400 focus:border-blue-400 outline-none">
                <option value="">-- Chọn loại vé --</option>
                <option value="TRIP" <c:if test="${param.ticketType=='TRIP'}">selected</c:if>>Vé lượt</option>
                <option value="DAY" <c:if test="${param.ticketType=='DAY'}">selected</c:if>>Vé ngày</option>
                <option value="MONTH" <c:if test="${param.ticketType=='MONTH'}">selected</c:if>>Vé tháng</option>
            </select>
        </form>

        <!-- FORM CHÍNH -->
        <form action="${pageContext.request.contextPath}/TicketServlet" method="post" class="space-y-3">
            <input type="hidden" name="action" value="sell">
            <input type="hidden" name="ticketType" value="${param.ticketType}">

            <!-- KHÁCH HÀNG -->
            <div>
                <label class="block text-sm font-medium mb-1">ID Khách hàng</label>
                <input type="text" name="customerId" required placeholder="VD: KH001"
                       class="w-full border border-slate-300 rounded-md px-2 py-2 text-sm focus:ring-1 focus:ring-blue-400 focus:border-blue-400 outline-none">
            </div>

            <!-- ID CHUYẾN -->
            <c:if test="${param.ticketType == 'TRIP'}">
                <div>
                    <label class="block text-sm font-medium mb-1">ID Chuyến</label>
                    <input type="number" name="tripId" required placeholder="Nhập ID chuyến"
                           class="w-full border border-slate-300 rounded-md px-2 py-2 text-sm focus:ring-1 focus:ring-blue-400 focus:border-blue-400 outline-none">
                </div>
            </c:if>

            <!-- TUYẾN -->
            <c:if test="${param.ticketType == 'DAY' || param.ticketType == 'MONTH'}">
                <div>
                    <label class="block text-sm font-medium mb-1">Tuyến</label>
                    <select name="routeId" required
                            class="w-full border border-slate-300 rounded-md px-2 py-2 text-sm focus:ring-1 focus:ring-blue-400 focus:border-blue-400 outline-none">
                        <option value="">-- Chọn tuyến --</option>
                        <c:forEach var="r" items="${routes}">
                            <option value="${r.route_id}">Tuyến ${r.route_id}: ${r.route_name}</option>
                        </c:forEach>
                    </select>
                </div>
            </c:if>

            <!-- GIÁ VÉ -->
            <div>
                <label class="block text-sm font-medium mb-1">Giá vé (VNĐ)</label>
                <c:choose>
                    <c:when test="${param.ticketType == 'TRIP'}">
                        <input type="hidden" name="price" value="15000">
                        <input type="text" value="15,000 VNĐ" readonly class="w-full bg-gray-100 border border-slate-200 rounded-md px-2 py-2 text-sm">
                    </c:when>
                    <c:when test="${param.ticketType == 'DAY'}">
                        <input type="hidden" name="price" value="50000">
                        <input type="text" value="50,000 VNĐ" readonly class="w-full bg-gray-100 border border-slate-200 rounded-md px-2 py-2 text-sm">
                    </c:when>
                    <c:when test="${param.ticketType == 'MONTH'}">
                        <input type="hidden" name="price" value="200000">
                        <input type="text" value="200,000 VNĐ" readonly class="w-full bg-gray-100 border border-slate-200 rounded-md px-2 py-2 text-sm">
                    </c:when>
                </c:choose>
            </div>

            <!-- HÌNH THỨC THANH TOÁN -->
            <div>
                <label class="block text-sm font-medium mb-1">Hình thức thanh toán</label>
                <select name="paymentMethod" required class="w-full border border-slate-300 rounded-md px-2 py-2 text-sm">
                    <option value="">-- Chọn phương thức --</option>
                    <option value="CASH">Tiền mặt</option>
                    <option value="ONLINE">Online</option>
                </select>
            </div>

            <!-- Ngân hàng -->
            <c:if test="${param.paymentMethod == 'ONLINE'}">
                <div class="bg-blue-50 border border-blue-200 rounded-md px-3 py-2 mt-2 text-sm text-slate-700">
                    💳 <b>Ngân hàng:</b> MB Bank<br>
                    🏦 <b>Số tài khoản:</b> 0965047076
                </div>
                <input type="hidden" name="bank" value="mbbank">
                <input type="hidden" name="stk" value="0965047076">
            </c:if>

            <!-- NÚT -->
            <div class="mt-4 space-y-2">
                <button type="submit"
                        class="w-full bg-blue-600 hover:bg-blue-700 text-white py-3 text-sm rounded-md font-medium">
                    💰 Bán Vé
                </button>
                <a href="${pageContext.request.contextPath}/view/ticket/main.jsp"
                   class="block w-full text-center bg-slate-400 hover:bg-slate-500 text-white py-3 text-sm rounded-md font-medium">
                    ⬅️ Quay Lại
                </a>
            </div>
        </form>
    </div>
</body>
</html>

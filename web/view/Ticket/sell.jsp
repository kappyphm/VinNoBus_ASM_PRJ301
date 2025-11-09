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

    <!-- FONT + TAILWIND -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@400;500;600;700&display=swap" rel="stylesheet">

    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        mono: ['Roboto Mono', 'ui-monospace', 'SFMono-Regular']
                    },
                    colors: {
                        brand: {
                            50: '#eff6ff',
                            100: '#dbeafe',
                            200: '#bfdbfe',
                            300: '#93c5fd',
                            400: '#60a5fa',
                            500: '#3b82f6',
                            600: '#2563eb',
                            700: '#1d4ed8',
                            800: '#1e40af',
                            900: '#1e3a8a',
                        },
                    },
                    boxShadow: {
                        soft: '0 6px 20px rgba(0,0,0,0.05)'
                    }
                }
            }
        }
    </script>
</head>

<body class="bg-brand-50 min-h-screen flex items-center justify-center font-mono text-slate-800">

    <!-- 🌸 KHUNG TRUNG TÂM -->
    <div class="bg-white rounded-2xl shadow-soft p-6 w-full max-w-md border border-slate-200">

        <!-- ICON + TIÊU ĐỀ -->
        <div class="flex flex-col items-center mb-5">
            <div class="w-9 h-9 rounded-lg bg-brand-600 text-white grid place-items-center text-lg shadow-soft">🎟️</div>
            <h1 class="text-lg font-semibold text-brand-700 mt-2">Bán Vé Xe Buýt</h1>
        </div>

        <!-- FORM -->
        <form action="${pageContext.request.contextPath}/view/ticket/sell.jsp" method="post" class="space-y-3">
            <input type="hidden" name="action" value="sell">

            <!-- NGƯỜI TẠO -->
            <div>
                <label class="block text-[13px] font-semibold mb-1">Người tạo (ID)</label>
                <input type="text" name="createdBy" value="${param.createdBy}" required
                       class="w-full border border-slate-300 rounded-md px-2 py-[4px] text-[13px] focus:ring-1 focus:ring-brand-400 focus:border-brand-400 outline-none">
            </div>

            <!-- KHÁCH HÀNG -->
            <div>
                <label class="block text-[13px] font-semibold mb-1">ID Khách hàng</label>
                <input type="text" name="customerId" value="${param.customerId}" required
                       class="w-full border border-slate-300 rounded-md px-2 py-[4px] text-[13px] focus:ring-1 focus:ring-brand-400 focus:border-brand-400 outline-none">
            </div>

            <!-- LOẠI VÉ -->
            <div>
                <label class="block text-[13px] font-semibold mb-1">Loại vé</label>
                <select name="ticketType" onchange="this.form.submit()"
                        class="w-full border border-slate-300 rounded-md px-2 py-[4px] text-[13px] focus:ring-1 focus:ring-brand-400 focus:border-brand-400 outline-none">
                    <option value="">-- Chọn loại vé --</option>
                    <option value="TRIP" <c:if test="${param.ticketType=='TRIP'}">selected</c:if>>Vé lượt</option>
                    <option value="DAY" <c:if test="${param.ticketType=='DAY'}">selected</c:if>>Vé ngày</option>
                    <option value="MONTH" <c:if test="${param.ticketType=='MONTH'}">selected</c:if>>Vé tháng</option>
                </select>
            </div>

            <!-- ID CHUYẾN -->
            <c:if test="${param.ticketType == 'TRIP' || empty param.ticketType}">
                <div>
                    <label class="block text-[13px] font-semibold mb-1">ID Chuyến (vé lượt)</label>
                    <input type="number" name="tripId" value="${param.tripId}" required
                           placeholder="Nhập ID chuyến"
                           class="w-full border border-slate-300 rounded-md px-2 py-[4px] text-[13px] focus:ring-1 focus:ring-brand-400 focus:border-brand-400 outline-none">
                </div>
            </c:if>

            <!-- TUYẾN -->
            <c:if test="${param.ticketType == 'DAY' || param.ticketType == 'MONTH'}">
                <div>
                    <label class="block text-[13px] font-semibold mb-1">Tuyến (vé ngày/tháng)</label>
                    <select name="routeId" required
                            class="w-full border border-slate-300 rounded-md px-2 py-[4px] text-[13px] focus:ring-1 focus:ring-brand-400 focus:border-brand-400 outline-none">
                        <option value="">-- Chọn tuyến --</option>
                        <c:forEach var="r" items="${routes}">
                            <option value="${r.route_id}" <c:if test="${param.routeId == r.route_id}">selected</c:if>>
                                Tuyến ${r.route_id}: ${r.route_name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </c:if>

            <!-- GIÁ VÉ -->
            <div>
                <label class="block text-[13px] font-semibold mb-1">Giá vé (VNĐ)</label>
                <input type="number" step="0.01" name="price" value="${param.price}" required
                       class="w-full border border-slate-300 rounded-md px-2 py-[4px] text-[13px] focus:ring-1 focus:ring-brand-400 focus:border-brand-400 outline-none">
            </div>

            <!-- THANH TOÁN -->
            <div>
                <label class="block text-[13px] font-semibold mb-1">Hình thức thanh toán</label>
                <select name="paymentMethod" required
                        class="w-full border border-slate-300 rounded-md px-2 py-[4px] text-[13px] focus:ring-1 focus:ring-brand-400 focus:border-brand-400 outline-none">
                    <option value="CASH" <c:if test="${param.paymentMethod=='CASH'}">selected</c:if>>Tiền mặt</option>
                    <option value="ONLINE" <c:if test="${param.paymentMethod=='ONLINE'}">selected</c:if>>Online</option>
                </select>
            </div>

            <!-- NGÂN HÀNG -->
            <div>
                <label class="block text-[13px] font-semibold mb-1">Ngân hàng</label>
                <input type="text" name="bank" value="MB" readonly
                       class="w-full border border-slate-200 rounded-md px-2 py-[4px] bg-gray-100 text-gray-700 text-[13px] cursor-not-allowed">
            </div>

            <!-- STK -->
            <div>
                <label class="block text-[13px] font-semibold mb-1">Số tài khoản</label>
                <input type="text" name="stk" value="0965047076" readonly
                       class="w-full border border-slate-200 rounded-md px-2 py-[4px] bg-gray-100 text-gray-700 text-[13px] cursor-not-allowed">
            </div>

            <!-- NÚT -->
            <div class="mt-4 space-y-2">
                <button formaction="${pageContext.request.contextPath}/view/ticket/invoice.jsp"
                        type="submit"
                        class="w-full bg-brand-600 hover:bg-brand-700 text-white py-[6px] text-[14px] rounded-md font-medium transition-all shadow-soft">
                    💰 Bán Vé
                </button>

                <a href="${pageContext.request.contextPath}/ticket/main.jsp"
                   class="block w-full text-center bg-slate-400 hover:bg-slate-500 text-white py-[6px] text-[14px] rounded-md font-medium transition-all shadow-soft">
                    ⬅️ Quay Lại
                </a>
            </div>
        </form>
    </div>

</body>
</html>

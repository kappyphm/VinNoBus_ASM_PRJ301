<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Hóa Đơn • VinNoBus</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@400;500;600&display=swap" rel="stylesheet">
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-blue-50 min-h-screen flex items-center justify-center font-[Roboto_Mono]">
        <div class="bg-white rounded-2xl shadow p-6 w-full max-w-md border border-slate-200">
            <div class="flex flex-col items-center mb-4">
                <div class="w-9 h-9 rounded-lg bg-blue-600 text-white grid place-items-center text-lg shadow">🧾</div>
                <h1 class="mt-2 mb-3 text-blue-700 font-semibold text-lg">Hóa Đơn Thanh Toán</h1>
            </div>

            <table class="w-full text-sm border-t border-slate-200 mb-5">
                <tr class="border-b border-slate-200">
                    <th class="text-left py-1 pr-2 w-1/3">Khách hàng</th>
                    <td class="py-1">${customerId}</td>
                </tr>
                <tr class="border-b border-slate-200">
                    <th class="text-left py-1 pr-2">Loại vé</th>
                    <td class="py-1">${ticketType}</td>
                </tr>
                <c:if test="${not empty tripId}">
                    <tr class="border-b border-slate-200">
                        <th class="text-left py-1 pr-2">ID Chuyến</th>
                        <td class="py-1">${tripId}</td>
                    </tr>
                </c:if>
                <c:if test="${not empty routeId}">
                    <tr class="border-b border-slate-200">
                        <th class="text-left py-1 pr-2">Tuyến</th>
                        <td class="py-1">Tuyến ${routeId}</td>
                    </tr>
                </c:if>
                <tr class="border-b border-slate-200">
                    <th class="text-left py-1 pr-2">Giá vé</th>
                    <td class="py-1">
                        <c:choose>
                            <c:when test="${not empty price}">
                                <fmt:formatNumber value="${price}" type="number"/> VNĐ
                            </c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr class="border-b border-slate-200">
                    <th class="text-left py-1 pr-2">Thanh toán</th>
                    <td class="py-1">${paymentMethod}</td>
                </tr>
            </table>

            <!-- QR Thanh Toán -->
            <c:if test="${paymentMethod == 'ONLINE'}">
                <c:set var="qr"
                       value="https://img.vietqr.io/image/${bank}-${stk}-compact2.jpg?amount=${price}&addInfo=Thanh+toan+ve+xe"/>
                <div class="text-center mt-5">
                    <h2 class="text-blue-700 text-[14px] font-semibold mb-2">Mã QR Thanh Toán</h2>
                    <img src="${qr}" alt="QR Thanh toán"
                         onerror="this.style.display='none'; document.getElementById('qrError').style.display='block';"
                         class="mx-auto w-56 rounded-lg border border-slate-200 shadow-sm mb-2">
                    <p id="qrError" style="display:none" class="text-[12px] text-red-500">
                        ⚠️ Không thể tải ảnh QR. Vui lòng kiểm tra mã ngân hàng hoặc số tài khoản.
                    </p>
                    <!-- 👇 debug để xem link thực tế -->
                    <p class="text-[11px] text-slate-500 mt-1">Ngân hàng: ${bank} • STK: ${stk}</p>
                    <p class="text-[10px] text-blue-500 break-all">${qr}</p>
                </div>
            </c:if>

            <c:if test="${paymentMethod == 'CASH'}">
                <div class="mt-4 bg-green-50 border-l-4 border-green-600 rounded-xl p-3 text-[13px] text-green-700 font-medium">
                    💵 Khách hàng thanh toán bằng tiền mặt.
                </div>
            </c:if>

            <div class="flex gap-2 mt-6">
                <a href="${pageContext.request.contextPath}/view/ticket/sell.jsp" class="w-full">
                    <button type="button" class="w-full bg-blue-600 hover:bg-blue-700 text-white py-1.5 rounded-md text-[13px] font-medium shadow">
                        💰 Tiếp Tục Bán Vé
                    </button>
                </a>
                <a href="${pageContext.request.contextPath}/view/ticket/main.jsp" class="w-full">
                    <button type="button" class="w-full bg-slate-500 hover:bg-slate-600 text-white py-1.5 rounded-md text-[13px] font-medium shadow">
                        ⬅️ Trang Chính
                    </button>
                </a>
            </div>
        </div>
    </body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Hóa Đơn • VinNoBus</title>

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet">
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

    <body class="bg-brand-50 min-h-screen flex items-center justify-center text-slate-800">

        <div class="bg-white rounded-2xl shadow-soft p-8 w-full max-w-lg border border-slate-200">
            <div class="flex items-center justify-center mb-4">
                <div class="w-12 h-12 rounded-xl bg-brand-600 text-white grid place-items-center text-2xl shadow-soft">🧾</div>
            </div>

            <h1 class="text-xl font-semibold text-center text-brand-700 mb-6">Hóa Đơn Thanh Toán</h1>

            <c:if test="${not empty message}">
                <div class="mb-6 bg-brand-50 border-l-4 border-brand-600 rounded-xl p-4 text-sm text-brand-700 font-medium shadow-soft">
                    ✅ ${message}
                </div>
            </c:if>

            <table class="w-full text-sm border-t border-slate-200 mb-6">
                <tr class="border-b border-slate-200">
                    <th class="text-left py-2 pr-2 text-slate-600 w-1/3">Mã Hóa Đơn</th>
                    <td class="py-2 text-slate-800 font-semibold">${invoice.invoiceId}</td>
                </tr>
                <tr class="border-b border-slate-200">
                    <th class="text-left py-2 pr-2 text-slate-600">Phương Thức</th>
                    <td class="py-2 text-slate-800 font-semibold">${invoice.paymentMethod}</td>
                </tr>
                <tr class="border-b border-slate-200">
                    <th class="text-left py-2 pr-2 text-slate-600">Ngày Thanh Toán</th>
                    <td class="py-2 text-slate-800">
                        <fmt:formatDate value="${invoice.paymentDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                    </td>
                </tr>
                <tr class="border-b border-slate-200">
                    <th class="text-left py-2 pr-2 text-slate-600">Trạng Thái</th>
                    <td class="py-2 text-slate-800 font-semibold">${invoice.status}</td>
                </tr>
                <tr class="border-b border-slate-200">
                    <th class="text-left py-2 pr-2 text-slate-600">Khách Hàng</th>
                    <td class="py-2 text-slate-800">${ticket.customerId}</td>
                </tr>
                <tr class="border-b border-slate-200">
                    <th class="text-left py-2 pr-2 text-slate-600">Loại Vé</th>
                    <td class="py-2 text-slate-800">${ticketType}</td>
                </tr>
                <tr class="border-b border-slate-200">
                    <th class="text-left py-2 pr-2 text-slate-600">Giá Vé</th>
                    <td class="py-2 text-slate-800"><fmt:formatNumber value="${ticket.price}" type="number"/> VNĐ</td>
                </tr>

                <tr>
                    <th class="text-left py-2 pr-2 text-slate-600">Tổng Tiền</th>
                    <td class="py-2 text-red-600 font-semibold text-base">
                        <c:choose>
                            <c:when test="${not empty total}">
                                <fmt:formatNumber value="${total}" type="number"/> VNĐ
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${ticket.price}" type="number"/> VNĐ
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </table>

            <c:if test="${not empty qr}">
                <div class="text-center mt-6">
                    <h2 class="text-brand-700 text-lg font-semibold mb-2">Mã QR Thanh Toán</h2>
                    <img src="${qr}" alt="QR Thanh toán" class="mx-auto w-64 rounded-lg border border-slate-200 shadow-soft mb-2">
                    <p class="text-xs text-slate-500">Ngân hàng: ${bank} • STK: ${stk}</p>
                </div>
            </c:if>

            <div class="flex gap-3 mt-8">
                <a href="${pageContext.request.contextPath}/view/Ticket/sell.jsp" class="w-full">
                    <button type="button"
                            class="w-full bg-brand-600 hover:bg-brand-700 text-white py-2.5 rounded-xl font-medium transition-all shadow-soft">
                        💰 Tiếp Tục Bán Vé
                    </button>
                </a>

                <a href="${pageContext.request.contextPath}/view/Ticket/main.jsp" class="w-full">
                    <button type="button"
                            class="w-full bg-slate-500 hover:bg-slate-600 text-white py-2.5 rounded-xl font-medium transition-all shadow-soft">
                        ⬅️ Trang Chính
                    </button>
                </a>
            </div>

        </div>

    </body>
</html>

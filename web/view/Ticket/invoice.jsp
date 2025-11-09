<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hóa Đơn • VinNoBus</title>

    <!-- FONT + TAILWIND -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@400;500;600&display=swap" rel="stylesheet">

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
                        soft: '0 6px 18px rgba(0,0,0,0.05)'
                    }
                }
            }
        }
    </script>

    <style>
        html {
            font-family: 'Roboto Mono', ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
        }

        th {
            font-weight: 600;
            font-size: 13px;
            color: #1e293b;
        }

        td {
            font-size: 13px;
            color: #0f172a;
        }

        h1 {
            font-weight: 600;
            font-size: 17px;
            color: #1d4ed8;
        }

        .qr-border {
            border: 1px solid #e2e8f0;
        }
    </style>
</head>

<body class="bg-brand-50 min-h-screen flex items-center justify-center font-mono text-slate-800">

    <div class="bg-white rounded-2xl shadow-soft p-6 w-full max-w-md border border-slate-200">
        <div class="flex flex-col items-center mb-4">
            <div class="w-9 h-9 rounded-lg bg-brand-600 text-white grid place-items-center text-lg shadow-soft">🧾</div>
            <h1 class="mt-2 mb-3">Hóa Đơn Thanh Toán</h1>
        </div>

        <table class="w-full text-sm border-t border-slate-200 mb-5">
            <tr class="border-b border-slate-200">
                <th class="text-left py-1 pr-2 w-1/3">Người Tạo</th>
                <td class="py-1">${param.createdBy}</td>
            </tr>
            <tr class="border-b border-slate-200">
                <th class="text-left py-1 pr-2">Khách Hàng</th>
                <td class="py-1">${param.customerId}</td>
            </tr>
            <tr class="border-b border-slate-200">
                <th class="text-left py-1 pr-2">ID Chuyến</th>
                <td class="py-1">
                    <c:choose>
                        <c:when test="${not empty param.tripId}">${param.tripId}</c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr class="border-b border-slate-200">
                <th class="text-left py-1 pr-2">Tuyến</th>
                <td class="py-1">
                    <c:choose>
                        <c:when test="${not empty param.routeId}">Tuyến ${param.routeId}</c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr class="border-b border-slate-200">
                <th class="text-left py-1 pr-2">Loại Vé</th>
                <td class="py-1">${param.ticketType}</td>
            </tr>
            <tr class="border-b border-slate-200">
                <th class="text-left py-1 pr-2">Giá Vé</th>
                <td class="py-1"><fmt:formatNumber value="${param.price}" type="number"/> VNĐ</td>
            </tr>
            <tr class="border-b border-slate-200">
                <th class="text-left py-1 pr-2">Hình Thức Thanh Toán</th>
                <td class="py-1">${param.paymentMethod}</td>
            </tr>
            <tr>
                <th class="text-left py-1 pr-2">Thời Gian</th>
                <td class="py-1">
                    <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy HH:mm:ss"/>
                </td>
            </tr>
        </table>

        <!-- QR Thanh Toán -->
        <c:if test="${param.paymentMethod == 'ONLINE'}">
            <c:set var="qr" value="https://img.vietqr.io/image/${param.bank}-${param.stk}-compact2.jpg?amount=${param.price}&addInfo=Thanh+toan+ve+xe"/>
            <div class="text-center mt-5">
                <h2 class="text-brand-700 text-[14px] font-semibold mb-2">Mã QR Thanh Toán</h2>
                <img src="${qr}" alt="QR Thanh toán"
                     class="mx-auto w-56 rounded-lg qr-border shadow-sm mb-2">
                <p class="text-[11px] text-slate-500">Ngân hàng: ${param.bank} • STK: ${param.stk}</p>
            </div>
        </c:if>

        <!-- Tiền mặt -->
        <c:if test="${param.paymentMethod == 'CASH'}">
            <div class="mt-4 bg-green-50 border-l-4 border-green-600 rounded-xl p-3 text-[13px] text-green-700 font-medium shadow-soft">
                💵 Khách hàng thanh toán bằng tiền mặt.
            </div>
        </c:if>

        <!-- Nút -->
        <div class="flex gap-2 mt-6">
            <a href="${pageContext.request.contextPath}/view/ticket/sell.jsp" class="w-full">
                <button type="button"
                        class="w-full bg-brand-600 hover:bg-brand-700 text-white py-1.5 rounded-md text-[13px] font-medium transition-all shadow-soft">
                    💰 Tiếp Tục Bán Vé
                </button>
            </a>
            <a href="${pageContext.request.contextPath}/view/ticket/main.jsp" class="w-full">
                <button type="button"
                        class="w-full bg-slate-500 hover:bg-slate-600 text-white py-1.5 rounded-md text-[13px] font-medium transition-all shadow-soft">
                    ⬅️ Trang Chính
                </button>
            </a>
        </div>
    </div>

</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Mua vé lượt • VinNoBus</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@400;500;600;700&display=swap" rel="stylesheet">
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        fontFamily: {mono: ['Roboto Mono', 'ui-monospace', 'SFMono-Regular']},
                        colors: {
                            brand: {50: '#eff6ff', 100: '#dbeafe', 200: '#bfdbfe', 300: '#93c5fd', 400: '#60a5fa', 500: '#3b82f6', 600: '#2563eb', 700: '#1d4ed8', 800: '#1e40af', 900: '#1e3a8a'},
                            bus: {600: '#00713d', 700: '#005f33'}
                        },
                        boxShadow: {soft: '0 8px 24px rgba(2,6,23,.06)'}
                    }
                }
            }
        </script>
        <style>
            html {
                font-family:'Roboto Mono',ui-monospace,SFMono-Regular,Menlo,Monaco,Consolas,'Courier New',monospace
            }
        </style>
    </head>

    <body class="bg-brand-50 min-h-screen flex items-center justify-center p-6 text-slate-800">

        <div class="bg-white rounded-2xl shadow-soft p-8 w-full max-w-md border border-slate-200">
            <div class="flex items-center justify-center mb-5">
                <div class="w-12 h-12 rounded-xl bg-bus-600 text-white grid place-items-center text-2xl shadow-soft">🚌</div>
            </div>

            <h1 class="text-xl font-semibold text-center text-bus-700 mb-6">Mua vé lượt</h1>

            <!-- Form nhập thông tin -->
            <form action="${pageContext.request.contextPath}/buy" method="post" class="space-y-4">
                <input type="hidden" name="action" value="calcTrip">

                <div>
                    <label class="block text-sm font-medium mb-1">ID khách hàng</label>
                    <input type="text" name="customerId" value="${customerId}" required class="w-full border border-slate-300 rounded-lg px-3 py-2">
                </div>

                <div>
                    <label class="block text-sm font-medium mb-1">ID chuyến</label>
                    <input type="number" name="tripId" value="${tripId}" required class="w-full border border-slate-300 rounded-lg px-3 py-2">
                </div>

                <div>
                    <label class="block text-sm font-medium mb-1">Số lượng vé</label>
                    <input type="number" name="quantity" min="1" value="${qty != null ? qty : 1}" required class="w-full border border-slate-300 rounded-lg px-3 py-2">
                </div>

                <div>
                    <label class="block text-sm font-medium mb-1">Giá vé (VND)</label>
                    <input type="number" step="0.01" name="price" value="${price}" required class="w-full border border-slate-300 rounded-lg px-3 py-2">
                </div>

                <div>
                    <label class="block text-sm font-medium mb-1">Ngân hàng</label>
                    <input type="text" name="bank" value="${param.bank}" required class="w-full border border-slate-300 rounded-lg px-3 py-2">
                </div>

                <div>
                    <label class="block text-sm font-medium mb-1">Số tài khoản</label>
                    <input type="text" name="stk" value="${param.stk}" required class="w-full border border-slate-300 rounded-lg px-3 py-2">
                </div>

                <button type="submit"
                        class="w-full bg-bus-600 hover:bg-bus-700 text-white py-2.5 rounded-xl font-medium transition-all shadow-soft">
                    💰 Tính tiền
                </button>
            </form>

            <!-- Hiển thị hóa đơn -->
            <c:if test="${not empty total}">
                <div class="mt-8 bg-emerald-50 border-l-4 border-bus-600 rounded-xl p-5">
                    <h2 class="font-semibold text-bus-700 text-lg mb-3">🧾 Hóa đơn thanh toán</h2>

                    <div class="text-sm space-y-1">
                        <p><b>Khách hàng:</b> ${customerId}</p>
                        <p><b>Trip:</b> ${tripId}</p>
                        <p><b>Số lượng:</b> ${qty}</p>
                        <p><b>Giá mỗi vé:</b> ${price} VND</p>
                        <p><b>Tổng tiền:</b> <span class="text-red-600 font-semibold text-base">${total} VND</span></p>
                    </div>

                    <img src="${qr}" alt="QR Thanh toán" class="mx-auto mt-4 rounded-lg w-64 shadow-md border border-slate-200">

                    <form action="${pageContext.request.contextPath}/buy" method="post" class="mt-5">
                        <input type="hidden" name="action" value="buyTrip">
                        <input type="hidden" name="customerId" value="${customerId}">
                        <input type="hidden" name="tripId" value="${tripId}">
                        <input type="hidden" name="quantity" value="${qty}">
                        <input type="hidden" name="price" value="${price}">
                        <button
                            class="w-full bg-bus-600 hover:bg-bus-700 text-white py-2.5 rounded-xl font-semibold shadow-soft transition-all">
                            ✅ Xác nhận đã chuyển khoản
                        </button>
                    </form>
                </div>
            </c:if>
        </div>

    </body>
</html>

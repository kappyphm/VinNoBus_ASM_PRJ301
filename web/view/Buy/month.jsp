<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <header class="border-b border-slate-200 bg-white shadow-soft">
            <div class="max-w-5xl mx-auto px-5 py-4 flex items-center justify-between">
                <a href="/home.jsp" class="flex items-center gap-2">
                    <div class="w-8 h-8 rounded-xl bg-brand-600 text-white grid place-items-center font-semibold">V</div>
                    <span class="font-semibold">VinNoBus</span>
                </a>
                <!--<a href="/routes/search" class="text-sm text-brand-700 hover:underline">Tìm tuyến xe</a>-->
            </div>
        </header>

        <!-- Main -->
        <main class="max-w-lg mx-auto p-6 mt-10 bg-white rounded-2xl shadow-soft">
            <h1 class="text-2xl font-semibold text-brand-700 text-center mb-6">Mua vé tháng</h1>

            <!-- Form tính tiền -->
            <form action="${pageContext.request.contextPath}/buy" method="post" class="space-y-4">
                <input type="hidden" name="action" value="calcMonth" />

                <div>
                    <label class="block text-sm font-medium mb-1">ID khách hàng</label>
                    <input type="text" name="customerId" value="${sessionScope.user.userId}" readonly
                           class="w-full px-3 py-2 rounded-xl border border-slate-200 bg-slate-50 text-slate-600" />
                </div>

                <div>
                    <label class="block text-sm font-medium mb-1">Tuyến bus</label>
                    <select name="routeId" required
                            class="w-full px-3 py-2 rounded-xl border border-slate-200 bg-white">
                        <option value="1">Tuyến 1: Thanh Miện - Hải Dương</option>
                        <option value="2">Tuyến 2: Hải Dương - Hà Nội</option>
                        <option value="3">Tuyến 3: Hải Dương - Bắc Ninh</option>
                    </select>
                </div>

                <div>
                    <label class="block text-sm font-medium mb-1">Ngân hàng</label>
                    <input type="text" name="bank" placeholder="Ví dụ: MB"
                           class="w-full px-3 py-2 rounded-xl border border-slate-200 bg-white" required />
                </div>

                <div>
                    <label class="block text-sm font-medium mb-1">Số tài khoản</label>
                    <input type="text" name="stk" placeholder="Nhập STK của bạn"
                           class="w-full px-3 py-2 rounded-xl border border-slate-200 bg-white" required />
                </div>

                <button type="submit"
                        class="w-full py-3 bg-brand-600 text-white rounded-xl font-semibold hover:bg-brand-700 transition">
                    Tính tiền
                </button>
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

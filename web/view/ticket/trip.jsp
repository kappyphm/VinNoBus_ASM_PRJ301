<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Tạo Vé Lượt - VinNoBus</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">

        <script>
            // ⚙️ Ẩn/hiện ô nhập Ngân hàng + STK
            function toggleBankFields() {
                const payment = document.getElementById("paymentMethod").value;
                const bankFields = document.getElementById("bankFields");
                bankFields.style.display = payment === "QR" ? "block" : "none";
            }

            // ⚙️ Tự động tính tổng tiền khi thay đổi số lượng
            function updateTotal() {
                const pricePerTicket = 15000; // giá cố định
                const qty = document.getElementById("quantity").value || 1;
                const total = pricePerTicket * qty;
                document.getElementById("totalAmount").innerText = total.toLocaleString("vi-VN") + " VNĐ";
            }

            window.onload = function () {
                toggleBankFields();
                updateTotal();
            }
        </script>
    </head>

    <body class="bg-gray-100 flex items-center justify-center min-h-screen">

        <div class="bg-white shadow-lg rounded-2xl p-8 w-full max-w-md">
            <h1 class="text-2xl font-bold text-blue-700 mb-6 text-center">🎟️ Tạo Vé Lượt</h1>

            <form action="${pageContext.request.contextPath}/TicketServlet" method="post" class="space-y-4">
                <input type="hidden" name="action" value="trip">

                <label class="block font-semibold">ID chuyến:</label>
        <input type="number" name="tripId" class="border border-gray-300 rounded-lg px-4 py-2 w-full" placeholder="VD: 101" required>

                <label class="block font-semibold">Số lượng vé:</label>
                <input type="number" id="quantity" name="quantity" min="1" value="1"
                       class="border border-gray-300 rounded-lg px-4 py-2 w-full" onchange="updateTotal()">

                <p class="font-semibold text-gray-600 mt-1">
                    💰 Tổng tiền: <span id="totalAmount" class="text-blue-600 font-bold"></span>
                </p>

                <label class="block font-semibold mt-3">Phương thức thanh toán:</label>
                <select id="paymentMethod" name="paymentMethod"
                        class="border border-gray-300 rounded-lg px-4 py-2 w-full"
                        onchange="toggleBankFields()">
                    <option value="CASH">💵 Tiền mặt</option>
                    <option value="QR">💳 Quét QR</option>
                </select>

                <div id="bankFields" class="space-y-2" style="display: none;">
                    <label class="block font-semibold">Ngân hàng:</label>
                    <input type="text" id="bank" name="bank" placeholder="VCB, MBB, TCB..."
                           class="border border-gray-300 rounded-lg px-4 py-2 w-full">

                    <label class="block font-semibold">Số tài khoản:</label>
                    <input type="text" id="stk" name="stk" placeholder="0123456789"
                           class="border border-gray-300 rounded-lg px-4 py-2 w-full">
                </div>

                <button type="submit"
                        class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 rounded-lg">
                    ➕ Tạo Vé
                </button>
            </form>

            <!-- Nếu sinh QR -->
            <c:if test="${not empty qr}">
                <div class="mt-6 text-center">
                    <p class="font-semibold mb-2">Quét mã để thanh toán:</p>
                    <img src="${qr}" alt="QR Thanh toán" class="mx-auto w-56 h-56 rounded-lg shadow-md border">
                    <p class="mt-2 text-sm text-gray-500">${bank} - ${stk}</p>

                    <form method="post" action="${pageContext.request.contextPath}/TicketServlet" class="mt-4">
                        <input type="hidden" name="action" value="trip">
                        <button type="submit"
                                class="w-full bg-green-600 hover:bg-green-700 text-white font-semibold py-2 rounded-lg">
                            ✅ Xác Nhận Thanh Toán Thành Công
                        </button>
                    </form>
                </div>
            </c:if>

            <c:if test="${not empty successMessage}">
                <div class="mt-6 bg-green-200 border border-green-500 text-green-800 font-semibold p-3 rounded-lg text-center">
                    ✅ ${successMessage}
                </div>
            </c:if>

            <div class="mt-6">
                <a href="${pageContext.request.contextPath}/view/ticket/checkinConductor.jsp"
                   class="block text-center bg-gray-500 hover:bg-gray-600 text-white font-semibold py-2 rounded-lg">
                    🔙 Quay Lại Check-in
                </a>
            </div>
        </div>

    </body>
</html>

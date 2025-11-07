<%-- 
    Document   : checkinConductor
    Created on : Nov 6, 2025, 9:54:32 PM
    Author     : Tham
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Check-in Vé - VinNoBus</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    </head>
    <body class="bg-gray-100 flex items-center justify-center min-h-screen">

        <div class="bg-white shadow-lg rounded-xl p-8 w-full max-w-md">
            <h1 class="text-2xl font-bold text-green-700 mb-6 text-center">🎟️ Check-in Vé Hành Khách</h1>

            <!-- Form kiểm tra vé -->
            <form action="${pageContext.request.contextPath}/TicketServlet" method="post" class="space-y-4">
                <input type="hidden" name="action" value="validate">
                <label class="block font-semibold">Mã vé:</label>
                <input type="text" name="ticketId" class="border border-gray-300 rounded-lg px-4 py-2 w-full" required>
                <button type="submit"
                        class="w-full bg-green-600 hover:bg-green-700 text-white font-semibold py-2 rounded-lg">
                    ✅ Kiểm Tra Vé
                </button>
            </form>

            <!-- Hiển thị kết quả -->
            <c:if test="${not empty checkMessage}">
                <div class="bg-green-100 border border-green-400 text-green-700 p-3 rounded-lg mt-4">
                    ${checkMessage}
                </div>

                <!-- Nút tạo vé lượt mới -->
                <form action="${pageContext.request.contextPath}/TicketServlet" method="post" class="mt-4">
                    <input type="hidden" name="action" value="trip">
                    <input type="hidden" name="customerId" value="${customerId}">
                    <input type="hidden" name="tripId" value="${tripId}">
                    <input type="hidden" name="price" value="${price}">
                    <button type="submit"
                            class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 rounded-lg">
                        ➕ Tạo Vé Lượt Mới
                    </button>
                </form>
            </c:if>

            <c:if test="${not empty error}">
                <div class="bg-red-100 border border-red-400 text-red-700 p-3 rounded-lg mt-4">
                    ${error}
                </div>
            </c:if>

        </div>

    </body>
</html>

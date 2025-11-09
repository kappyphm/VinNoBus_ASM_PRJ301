<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Check-in Vé Tháng • VinNoBus</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;600;700&display=swap" rel="stylesheet">
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          fontFamily: { mono: ['JetBrains Mono','ui-monospace','SFMono-Regular'] },
          colors: {
            brand:{50:'#eff6ff',100:'#dbeafe',200:'#bfdbfe',300:'#93c5fd',400:'#60a5fa',500:'#3b82f6',600:'#2563eb',700:'#1d4ed8',800:'#1e40af',900:'#1e3a8a'},
          },
          boxShadow: { soft:'0 8px 24px rgba(2,6,23,.06)' }
        }
      }
    }
  </script>
  <style>
    html { font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,Monaco,Consolas,'Courier New',monospace }
  </style>
</head>

<body class="bg-brand-50 min-h-screen flex items-center justify-center p-6 text-slate-800">

  <div class="bg-white rounded-2xl shadow-soft p-8 w-full max-w-md border border-slate-200">
    <div class="flex items-center justify-center mb-5">
      <div class="w-12 h-12 rounded-xl bg-brand-600 text-white grid place-items-center text-2xl shadow-soft">🎫</div>
    </div>

    <h1 class="text-xl font-semibold text-center text-brand-700 mb-6">Check-in Vé Tháng</h1>

    <!-- Form nhập thông tin -->
    <form action="${pageContext.request.contextPath}/TicketServlet" method="post" class="space-y-4">
      <input type="hidden" name="action" value="checkin">

      <div>
        <label class="block text-sm font-medium mb-1">ID Khách Hàng</label>
        <input type="text" name="customerId" required class="w-full border border-slate-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-brand-300 focus:border-brand-500">
      </div>

      <div>
        <label class="block text-sm font-medium mb-1">ID Tuyến</label>
        <input type="number" name="routeId" required class="w-full border border-slate-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-brand-300 focus:border-brand-500">
      </div>

      <div class="flex gap-3 pt-3">
        <button type="submit"
                class="w-full bg-brand-600 hover:bg-brand-700 text-white py-2.5 rounded-xl font-medium transition-all shadow-soft">
          ✅ Check-in
        </button>

        <a href="${pageContext.request.contextPath}/view/Ticket/main.jsp"
           class="w-full">
          <button type="button"
                  class="w-full bg-slate-500 hover:bg-slate-600 text-white py-2.5 rounded-xl font-medium transition-all shadow-soft">
            ⬅️ Quay Lại
          </button>
        </a>
      </div>
    </form>

    <!-- Hiển thị thông báo -->
    <c:if test="${not empty error}">
      <div class="mt-6 bg-red-50 border-l-4 border-red-600 rounded-xl p-4 text-sm text-red-700 font-medium shadow-soft">
        ❌ ${error}
      </div>
    </c:if>

    <c:if test="${not empty message}">
      <div class="mt-6 bg-brand-50 border-l-4 border-brand-600 rounded-xl p-4 text-sm text-brand-700 font-medium shadow-soft">
        ✅ ${message}
      </div>
    </c:if>
  </div>

</body>
</html>

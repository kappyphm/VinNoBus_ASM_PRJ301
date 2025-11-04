<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết Xe Bus</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
            @keyframes slideUp {
                from {
                    transform: translateY(40px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }
        </style>
    </head>
    <body class="font-[Segoe_UI] bg-gradient-to-br from-[#e6efff] to-[#f8fbff] text-[#333] min-h-screen">

        <!-- Header -->
        <header class="sticky top-0 z-10 bg-[rgba(0,98,204,0.9)] backdrop-blur-md text-white px-12 py-4 flex flex-wrap justify-between items-center shadow-[0_4px_15px_rgba(0,0,0,0.15)]">
            <div class="text-2xl font-bold">Hệ thống Xe Bus</div>
            <nav>
                <ul class="flex flex-wrap gap-6">
                    <li><a href="index.jsp" class="relative font-medium pb-1 after:content-[''] after:absolute after:w-0 after:h-[2px] after:bottom-0 after:left-0 after:bg-[#ffdd57] hover:after:w-full hover:text-[#ffdd57] transition-all duration-300">Trang chủ</a></li>
                    <li><a href="BusServlet?action=list" class="relative font-medium pb-1 after:content-[''] after:absolute after:w-0 after:h-[2px] after:bottom-0 after:left-0 after:bg-[#ffdd57] hover:after:w-full hover:text-[#ffdd57] transition-all duration-300">Danh sách</a></li>
                    <li><a href="BusServlet?action=addForm" class="relative font-medium pb-1 after:content-[''] after:absolute after:w-0 after:h-[2px] after:bottom-0 after:left-0 after:bg-[#ffdd57] hover:after:w-full hover:text-[#ffdd57] transition-all duration-300">Thêm mới</a></li>
                </ul>
            </nav>
        </header>

        <!-- Main -->
        <main class="flex justify-center items-center px-5 py-20 animate-[slideUp_0.8s_ease_forwards]">
            <div class="bg-white p-10 rounded-2xl shadow-[0_8px_25px_rgba(0,0,0,0.15)] w-[400px] text-left">
                <h2 class="text-center text-[#004a99] text-2xl font-semibold mb-6">Chi tiết Xe Bus</h2>

                <div class="mb-4 text-[16px]"><span class="font-semibold">Biển số xe:</span> ${bus.plateNumber}</div>
                <div class="mb-4 text-[16px]"><span class="font-semibold">Sức chứa:</span> ${bus.capacity}</div>
                <div class="mb-4 text-[16px]"><span class="font-semibold">Bus ID:</span> ${bus.busId}</div>
                <div class="mb-4 text-[16px]"><span class="font-semibold">Trạng thái:</span> 
                    <span class="
                          px-2 py-1 rounded-full text-white font-medium
                          <c:choose>
                              <c:when test='${bus.currentStatus == "AVAILABLE"}'>bg-green-500</c:when>
                              <c:when test='${bus.currentStatus == "IN_USE"}'>bg-blue-500</c:when>
                              <c:when test='${bus.currentStatus == "MAINTENANCE"}'>bg-yellow-500</c:when>
                              <c:when test='${bus.currentStatus == "BROKEN"}'>bg-red-500</c:when>
                              <c:when test='${bus.currentStatus == "REPAIRING"}'>bg-orange-500</c:when>
                              <c:when test='${bus.currentStatus == "RESERVED"}'>bg-purple-500</c:when>
                              <c:otherwise>bg-gray-500</c:otherwise>
                          </c:choose>
                          ">
                        ${bus.currentStatus}
                    </span>
                </div>

                <a href="BusServlet?action=list"
                   class="inline-block mt-5 px-5 py-3 rounded-xl font-medium text-white text-center
                   bg-gradient-to-br from-[#0078d7] to-[#005fa3]
                   shadow-[0_5px_15px_rgba(0,0,0,0.1)]
                   hover:from-[#005fa3] hover:to-[#004f88]
                   hover:-translate-y-[3px] hover:shadow-[0_8px_18px_rgba(0,0,0,0.2)]
                   transition-all duration-300">
                    ← Quay lại danh sách
                </a>
            </div>
        </main>

        <!-- Footer -->
        <footer class="text-center py-6 bg-[#f5f5f5] text-[#666] text-sm border-t border-[#ddd]">
            © 2025 Hệ thống quản lý xe bus. Mọi quyền được bảo lưu.
        </footer>

    </body>
</html>

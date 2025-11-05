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
                    transform: translateY(30px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }
            .animate-slideUp {
                animation: slideUp 0.8s ease-out forwards;
            }
        </style>
    </head>

    <body class="font-[Segoe_UI] bg-gradient-to-br from-blue-50 via-indigo-100 to-purple-50 text-gray-800 min-h-screen">
        <!-- Main -->
        <main class="flex justify-center items-center px-5 py-20 animate-slideUp">
            <div class="bg-white/90 backdrop-blur-md p-10 rounded-2xl shadow-[0_8px_25px_rgba(0,0,0,0.1)] w-full max-w-md border border-white/50">
                <h2 class="text-center text-3xl font-bold bg-gradient-to-r from-blue-700 via-indigo-700 to-purple-700 text-transparent bg-clip-text mb-8">
                    🚍 Chi tiết Xe Bus
                </h2>

                <div class="space-y-4 text-[16px]">
                    <div class="flex justify-between border-b pb-2">
                        <span class="font-semibold text-gray-600">🆔 Bus ID:</span>
                        <span>${bus.busId}</span>
                    </div>

                    <div class="flex justify-between border-b pb-2">
                        <span class="font-semibold text-gray-600">🚘 Biển số xe:</span>
                        <span class="text-gray-700 font-medium">${bus.plateNumber}</span>
                    </div>

                    <div class="flex justify-between border-b pb-2">
                        <span class="font-semibold text-gray-600">💺 Sức chứa:</span>
                        <span>${bus.capacity} chỗ</span>
                    </div>

                    <div class="flex justify-between items-center">
                        <span class="font-semibold text-gray-600">⚙️ Trạng thái:</span>
                        <span class="
                              px-3 py-1 rounded-full text-white font-medium text-sm shadow-md
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
                </div>

                <!-- Nút quay lại -->
                <div class="text-center mt-10">
                    <a href="BusServlet?action=list"
                       class="inline-block px-6 py-3 rounded-xl font-semibold text-white text-center
                       bg-gradient-to-r from-indigo-600 to-blue-600
                       shadow-[0_4px_15px_rgba(0,0,0,0.1)]
                       hover:from-blue-700 hover:to-indigo-700
                       hover:-translate-y-1 hover:shadow-[0_8px_20px_rgba(0,0,0,0.15)]
                       transition-all duration-300">
                        ← Quay lại danh sách
                    </a>
                </div>
            </div>
        </main>
    </body>
</html>

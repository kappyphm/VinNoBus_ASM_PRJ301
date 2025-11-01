<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Chỉnh sửa Xe Bus</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>
    </head>

    <body
        class="font-[Segoe_UI] bg-gradient-to-br from-[#74b9ff] to-[#a29bfe] flex justify-center items-center min-h-screen"
        >
        <div
            class="bg-white p-10 rounded-2xl shadow-[0_10px_25px_rgba(0,0,0,0.15)] w-[400px] text-center animate-[fadeIn_0.5s_ease]"
            >
            <h2 class="text-[#2d3436] text-2xl font-semibold mb-5">
                Chỉnh sửa Xe Bus
            </h2>

            <c:if test="${not empty message}">
                <div class="text-[#27ae60] font-semibold mb-4">${message}</div>
            </c:if>

            <form action="BusServlet" method="post" class="text-left">
                <input type="hidden" name="action" value="update" />
                <input
                    type="hidden"
                    name="bus_id"
                    value="${bus_id != null ? bus_id : bus.busId}"
                    />

                <label class="block font-semibold text-[#555] mt-4 mb-1"
                       >Biển số xe:</label
                >
                <input
                    type="text"
                    name="plate_number"
                    value="${plate_number != null ? plate_number : bus.plateNumber}"
                    placeholder="VD: 29B-123.45"
                    class="w-full px-3 py-2 border border-[#dcdde1] rounded-lg text-[15px] transition-all duration-300 focus:border-[#0984e3] focus:shadow-[0_0_8px_rgba(9,132,227,0.4)] outline-none"
                    />
                <c:if test="${not empty error_plate}">
                    <div class="text-[#d63031] font-semibold mt-1 text-sm">
                        ${error_plate}
                    </div>
                </c:if>

                <label class="block font-semibold text-[#555] mt-4 mb-1">Sức chứa:</label>
                <input
                    type="number"
                    name="capacity"
                    value="${capacity != null ? capacity : bus.capacity}"
                    min="1"
                    class="w-full px-3 py-2 border border-[#dcdde1] rounded-lg text-[15px] transition-all duration-300 focus:border-[#0984e3] focus:shadow-[0_0_8px_rgba(9,132,227,0.4)] outline-none"
                    />
                <c:if test="${not empty error_capacity}">
                    <div class="text-[#d63031] font-semibold mt-1 text-sm">
                        ${error_capacity}
                    </div>
                </c:if>

                <c:if test="${not empty error_general}">
                    <div class="text-[#d63031] font-semibold mt-2 text-sm">
                        ${error_general}
                    </div>
                </c:if>

                <div class="flex justify-between mt-6">
                    <a
                        href="BusServlet?action=list"
                        class="px-5 py-3 border border-[#ccc] rounded-lg bg-[#f8f9fa] text-[#333] font-medium hover:bg-[#e2e6ea] hover:-translate-y-[1px] transition-all duration-300"
                        >
                        ← Quay lại
                    </a>
                    <button
                        type="submit"
                        class="px-5 py-3 bg-[#0984e3] text-white rounded-lg font-semibold hover:bg-[#74b9ff] hover:-translate-y-[2px] hover:shadow-[0_4px_12px_rgba(0,0,0,0.2)] transition-all duration-300"
                        >
                        Cập nhật
                    </button>
                </div>
            </form>
        </div>
    </body>
</html>

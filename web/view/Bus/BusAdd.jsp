<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
    <head>
        <title>Thêm Xe Bus Mới</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="font-[Segoe_UI] bg-gradient-to-br from-[#74b9ff] to-[#a29bfe] flex justify-center items-center h-screen m-0">

        <div class="bg-white p-10 rounded-2xl shadow-[0_8px_25px_rgba(0,0,0,0.15)] w-[400px] text-center animate-[fadeIn_0.5s_ease]">
            <h2 class="text-[#2d3436] text-2xl font-semibold mb-5">Thêm Xe Bus Mới</h2>

            <!-- Hiển thị thông báo -->
            <c:if test="${not empty message}">
                <div class="text-[#27ae60] font-semibold mb-4">${message}</div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="text-[#d63031] font-semibold mb-4">${error}</div>
            </c:if>

            <form action="BusServlet" method="post" class="text-left">
                <input type="hidden" name="action" value="add">

                <label class="block font-semibold text-[#555] mt-4 mb-1">Biển số xe:</label>
                <input 
                    type="text" 
                    name="plate_number" 
                    placeholder="VD: 29B-123.45"
                    class="w-full px-3 py-2 border border-[#dcdde1] rounded-lg outline-none text-[15px] focus:border-[#0984e3] focus:shadow-[0_0_5px_rgba(9,132,227,0.4)] transition"
                    >

                <label class="block font-semibold text-[#555] mt-4 mb-1">Sức chứa:</label>
                <input 
                    type="number" 
                    name="capacity" 
                    placeholder="VD: 40"
                    class="w-full px-3 py-2 border border-[#dcdde1] rounded-lg outline-none text-[15px] focus:border-[#0984e3] focus:shadow-[0_0_5px_rgba(9,132,227,0.4)] transition"
                    >
                <label class="block font-semibold text-[#555] mt-4 mb-1">Trạng thái:</label>
                <select name="current_status" class="w-full px-3 py-2 border rounded-lg text-[15px] focus:border-[#0984e3] focus:shadow-[0_0_5px_rgba(9,132,227,0.4)]">
                    <option value="AVAILABLE">AVAILABLE</option>
                    <option value="IN_USE">IN_USE</option>
                    <option value="MAINTENANCE">MAINTENANCE</option>
                    <option value="BROKEN">BROKEN</option>
                    <option value="REPAIRING">REPAIRING</option>
                    <option value="RESERVED">RESERVED</option>
                </select>
                <button 
                    type="submit"
                    class="w-full bg-[#0984e3] text-white py-3 rounded-lg text-[16px] font-bold mt-5 cursor-pointer transition hover:bg-[#74b9ff]"
                    >
                    ➕ Thêm Xe Bus
                </button>

                <a 
                    href="BusServlet?action=list"
                    class="block text-center mt-5 text-[#636e72] text-sm hover:underline hover:text-[#2d3436]"
                    >
                    ← Quay lại danh sách
                </a>
            </form>
        </div>

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
    </body>
</html>

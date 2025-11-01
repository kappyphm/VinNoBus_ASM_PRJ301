<%-- 
    Document   : RouteAdd
    Created on : Oct 18, 2025, 12:21:03 PM
    Author     : Admin
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Thêm Tuyến Mới</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
            @keyframes fadeSlideUp {
                from {
                    opacity: 0;
                    transform: translateY(15px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .fadeSlideUp {
                animation: fadeSlideUp 0.6s ease-in-out;
            }
        </style>
    </head>
    <body class="min-h-screen flex items-center justify-center bg-gradient-to-br from-[#f5f7fa] to-[#eaf1f9] font-[Segoe_UI]">

        <div class="container w-[60%] bg-white p-10 rounded-2xl shadow-xl fadeSlideUp">
            <h2 class="text-center text-3xl font-bold text-[#2c3e50] mb-8">
                ➕ Thêm Tuyến Mới
            </h2>

            <% 
                String message = (String) session.getAttribute("message");
                String error = (String) request.getAttribute("errorMessage");
                if (message != null) { 
            %>
            <div class="text-center bg-[#d4edda] text-[#155724] border-l-4 border-[#2ecc71] py-3 px-4 rounded-lg mb-4 fadeSlideUp">
                <%= message %>
            </div>
            <% 
                session.removeAttribute("message");
                } 
                if (error != null) { 
            %>
            <div class="text-center bg-[#f8d7da] text-[#721c24] border-l-4 border-[#e74c3c] py-3 px-4 rounded-lg mb-4 fadeSlideUp">
                <%= error %>
            </div>
            <% } %>

            <form action="RouteServlet?action=add" method="post" class="flex flex-col gap-5 fadeSlideUp">
                <label class="font-semibold text-gray-700">Tên tuyến:</label>
                <input 
                    type="text" 
                    name="routeName" 
                    required 
                    class="border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-400 focus:outline-none transition-all duration-200 bg-[#f9f9f9] text-center"
                    >

                <label class="font-semibold text-gray-700">Loại tuyến:</label>
                <select 
                    name="type" 
                    required 
                    class="border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-400 focus:outline-none transition-all duration-200 bg-[#f9f9f9] text-center"
                    >
                    <option value="">-- Chọn loại --</option>
                    <option value="CIRCULAR">CIRCULAR</option>
                    <option value="ROUND_TRIP">ROUND_TRIP</option>
                </select>

                <label class="font-semibold text-gray-700">Tần suất (chuyến/ngày):</label>
                <input 
                    type="number" 
                    name="frequency" 
                    min="1" 
                    required 
                    class="border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-400 focus:outline-none transition-all duration-200 bg-[#f9f9f9] text-center"
                    >

                <div class="flex items-center justify-between mt-6">
                    <button 
                        type="submit" 
                        class="px-6 py-2 rounded-lg font-semibold text-white bg-gradient-to-r from-[#3498db] to-[#2ecc71] shadow-md hover:brightness-110 hover:-translate-y-1 transition-all duration-300"
                        >
                        Thêm Tuyến
                    </button>

                    <a 
                        href="RouteServlet?action=list" 
                        class="text-gray-600 hover:text-[#3498db] transition-all duration-200 font-medium"
                        >
                        ⬅ Quay lại danh sách
                    </a>
                </div>
            </form>
        </div>

    </body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Thêm trạm mới</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gradient-to-br from-blue-100 via-purple-100 to-pink-100 font-sans min-h-screen flex items-center justify-center p-6">

        <!-- Container chính với animation fade-in -->
        <div class="bg-white shadow-2xl rounded-xl w-full max-w-md p-8 transform transition-all duration-700 scale-95 opacity-0 animate-fadeIn">
            <h2 class="text-3xl font-extrabold mb-6 text-center text-gray-800">Thêm trạm mới</h2>

            <% if (request.getAttribute("error") != null) { %>
            <p class="text-red-600 font-semibold mb-4 text-center animate-pulse"><%= request.getAttribute("error") %></p>
            <% } %>

            <form action="StationServlet" method="post" class="space-y-5">
                <input type="hidden" name="action" value="create">

                <div class="relative">
                    <input type="text" name="stationName" required
                           class="peer w-full border-b-2 border-gray-300 py-2 px-0 focus:border-blue-500 focus:outline-none transition-colors duration-300"
                           placeholder=" ">
                    <label class="absolute left-0 -top-3.5 text-gray-500 text-sm transition-all peer-placeholder-shown:top-2 peer-placeholder-shown:text-gray-400 peer-placeholder-shown:text-base peer-focus:-top-3.5 peer-focus:text-gray-700 peer-focus:text-sm">Tên trạm</label>
                </div>

                <div class="relative">
                    <input type="text" name="location" required
                           class="peer w-full border-b-2 border-gray-300 py-2 px-0 focus:border-blue-500 focus:outline-none transition-colors duration-300"
                           placeholder=" ">
                    <label class="absolute left-0 -top-3.5 text-gray-500 text-sm transition-all peer-placeholder-shown:top-2 peer-placeholder-shown:text-gray-400 peer-placeholder-shown:text-base peer-focus:-top-3.5 peer-focus:text-gray-700 peer-focus:text-sm">Vị trí</label>
                </div>

                <div class="relative">
                    <input type="time" name="openTime"
                           class="peer w-full border-b-2 border-gray-300 py-2 px-0 focus:border-blue-500 focus:outline-none transition-colors duration-300">
                    <label class="absolute left-0 -top-3.5 text-gray-500 text-sm transition-all peer-focus:-top-3.5 peer-focus:text-gray-700">Giờ mở cửa</label>
                </div>

                <div class="relative">
                    <input type="time" name="closeTime"
                           class="peer w-full border-b-2 border-gray-300 py-2 px-0 focus:border-blue-500 focus:outline-none transition-colors duration-300">
                    <label class="absolute left-0 -top-3.5 text-gray-500 text-sm transition-all peer-focus:-top-3.5 peer-focus:text-gray-700">Giờ đóng cửa</label>
                </div>

                <div class="flex justify-between items-center mt-6">
                    <button type="submit"
                            class="bg-gradient-to-r from-blue-500 to-purple-500 text-white px-6 py-2 rounded-full shadow-lg hover:scale-105 hover:shadow-xl transform transition duration-300">Thêm trạm</button>
                    <a href="StationServlet?action=list"
                       class="text-gray-600 hover:text-gray-800 hover:underline transition-colors duration-300">Hủy</a>
                </div>
            </form>
        </div>

        <!-- Custom animation -->
        <style>
            @keyframes fadeIn {
                0% {
                    opacity: 0;
                    transform: scale(0.95);
                }
                100% {
                    opacity: 1;
                    transform: scale(1);
                }
            }
            .animate-fadeIn {
                animation: fadeIn 0.8s ease-out forwards;
            }
        </style>
    </body>
</html>

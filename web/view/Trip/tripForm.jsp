<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/header.jsp" %>

<script src="https://cdn.tailwindcss.com"></script>

<body class="min-h-screen bg-gradient-to-br from-indigo-50 via-purple-50 to-blue-100 font-['Segoe_UI'] p-6">

    <div class="max-w-2xl mx-auto bg-white/90 backdrop-blur-sm rounded-2xl shadow-md p-8 mt-10">
        
        <h2 class="text-3xl font-bold text-center mb-8 bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent">
            Tạo chuyến xe mới
        </h2>

        <c:if test="${not empty errors}">
            <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded-md mb-6" role="alert">
                <p class="font-bold">Đã xảy ra lỗi:</p>
                <ul class="list-disc list-inside ml-2">
                    <c:forEach var="err" items="${errors}">
                        <li>${err}</li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded-md mb-6" role="alert">
                <p class="font-bold">${success}</p>
            </div>
        </c:if>

        <form action="TripServlet?action=add" method="post">
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-5">
                <div>
                    <label for="routeId" class="block mb-2 text-sm font-medium text-gray-900">Mã tuyến xe:</label>
                    <input type="number" id="routeId" name="routeId" value="${routeId}" required
                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-indigo-500 focus:border-indigo-500 block w-full p-2.5"
                           placeholder="Nhập mã tuyến (ví dụ: 101)">
                </div>
                <div>
                    <label for="busId" class="block mb-2 text-sm font-medium text-gray-900">Mã xe buýt:</label>
                    <input type="number" id="busId" name="busId" value="${busId}" required
                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-indigo-500 focus:border-indigo-500 block w-full p-2.5"
                           placeholder="Nhập mã xe (ví dụ: 502)">
                </div>
            </div>

            <div class="mb-5">
                <label for="driverId" class="block mb-2 text-sm font-medium text-gray-900">Mã tài xế:</label>
                <input type="text" id="driverId" name="driverId" value="${driverId}" required
                       class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-indigo-500 focus:border-indigo-500 block w-full p-2.5"
                       placeholder="Nhập mã tài xế">
            </div>

            <div class="mb-5">
                <label for="conductorId" class="block mb-2 text-sm font-medium text-gray-900">Mã phụ xe:</label>
                <input type="text" id="conductorId" name="conductorId" value="${conductorId}" required
                       class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-indigo-500 focus:border-indigo-500 block w-full p-2.5"
                       placeholder="Nhập mã phụ xe">
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                <div>
                    <label for="departureTime" class="block mb-2 text-sm font-medium text-gray-900">Giờ khởi hành:</label>
                    <input type="datetime-local" id="departureTime" name="departureTime" value="${departureTime}" required
                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-indigo-500 focus:border-indigo-500 block w-full p-2.5">
                </div>
                <div>
                    <label for="arrivalTime" class="block mb-2 text-sm font-medium text-gray-900">Giờ kết thúc:</label>
                    <input type="datetime-local" id="arrivalTime" name="arrivalTime" value="${arrivalTime}" required
                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-indigo-500 focus:border-indigo-500 block w-full p-2.5">
                </div>
            </div>
            
            <div class="flex items-center justify-between">
                <button type="submit"
                        class="bg-gradient-to-r from-indigo-500 to-purple-500 text-white px-6 py-2.5 rounded-lg shadow-md hover:shadow-lg transition-all duration-200 hover:scale-105">
                    ➕ Thêm chuyến
                </button>
                <a href="TripServlet?action=list" class="text-sm font-medium text-indigo-600 hover:underline">
                    ← Quay lại danh sách
                </a>
            </div>
        </form>
    </div>

</body>
<%@ include file="/footer.jsp" %>
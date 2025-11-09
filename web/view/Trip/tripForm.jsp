<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdn.tailwindcss.com"></script>

<body class="min-h-screen bg-gradient-to-br from-indigo-50 via-purple-50 to-blue-100 font-['Segoe_UI'] p-6">

    <div class="max-w-xl mx-auto bg-white/90 backdrop-blur-sm rounded-2xl shadow-md p-8 mt-10">

        <h2 class="text-3xl font-bold text-center mb-8 bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent">
            Tạo chuyến xe mới (Bước 1/2)
        </h2>

        <%-- Hiển thị lỗi validation (nếu có) --%>
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

        <form action="TripServlet?action=createShell" method="post">

            <div class="mb-6">
                <label for="routeId" class="block mb-2 text-sm font-medium text-gray-900">Chọn tuyến xe để tạo chuyến:</label>
                <input type="text" list="routesData" id="routeId" name="routeId" value="${routeId}" required
                       class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-indigo-500 focus:border-indigo-500 block w-full p-2.5"
                       placeholder="Gõ số tuyến hoặc tên để chọn...">

                <datalist id="routesData">
                    <c:forEach var="route" items="${routesList}">
                        <option value="${route.routeId}">${route.routeName}</option>
                    </c:forEach>
                </datalist>
            </div>

            <div class="flex items-center justify-between">
                <button type="submit"
                        class="bg-gradient-to-r from-indigo-500 to-purple-500 text-white px-6 py-2.5 rounded-lg shadow-md hover:shadow-lg transition-all duration-200 hover:scale-105">
                    Tạo và tiếp tục 
                </button>
                <a href="TripServlet?action=list" class="text-sm font-medium text-indigo-600 hover:underline">
                    ← Quay lại danh sách
                </a>
            </div>
        </form>
    </div>

</body>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://cdn.tailwindcss.com"></script>
<body class="min-h-screen bg-gradient-to-br from-indigo-50 via-purple-50 to-blue-100 font-['Segoe_UI'] p-6">

    <div class="max-w-2xl mx-auto bg-white/90 backdrop-blur-sm rounded-2xl shadow-md p-8 mt-10">

        <h2 class="text-3xl font-bold text-center mb-8 bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent">
            Chi tiết chuyến xe 
        </h2>

        <div class="overflow-hidden rounded-lg border border-gray-200">
            <table class="min-w-full divide-y divide-gray-200">
                <tbody class="divide-y divide-gray-100 bg-white">

                    <tr class="hover:bg-indigo-50/50 transition">
                        <td class="px-6 py-4 w-1/3 text-sm font-medium text-gray-800">Mã chuyến</td>
                        <td class="px-6 py-4 text-sm text-gray-700 font-semibold">${trip.tripId}</td>
                    </tr>

                    <tr class="hover:bg-indigo-50/50 transition">
                        <td class="px-6 py-4 w-1/3 text-sm font-medium text-gray-800">Mã tuyến</td>
                        <td class="px-6 py-4 text-sm text-gray-700">${trip.routeId}</td>
                    </tr>

                    <tr class="hover:bg-indigo-50/50 transition">
                        <td class="px-6 py-4 w-1/3 text-sm font-medium text-gray-800">Mã xe buýt</td>
                        <td class="px-6 py-4 text-sm text-gray-700">${trip.busId}</td>
                    </tr>

                    <tr class="hover:bg-indigo-50/50 transition">
                        <td class="px-6 py-4 w-1/3 text-sm font-medium text-gray-800">Mã tài xế</td>
                        <td class="px-6 py-4 text-sm text-gray-700">${trip.driverId}</td>
                    </tr>

                    <tr class="hover:bg-indigo-50/50 transition">
                        <td class="px-6 py-4 w-1/3 text-sm font-medium text-gray-800">Mã phụ xe</td>
                        <td class="px-6 py-4 text-sm text-gray-700">${trip.conductorId}</td>
                    </tr>

                    <tr class="hover:bg-indigo-50/50 transition">
                        <td class="px-6 py-4 w-1/3 text-sm font-medium text-gray-800">Giờ khởi hành</td>
                        <td class="px-6 py-4 text-sm text-gray-700">
                            <fmt:formatDate value="${trip.departureTime}" pattern="HH:mm dd-MM-yyyy"/>
                        </td>
                    </tr>

                    <tr class="hover:bg-indigo-50/50 transition">
                        <td class="px-6 py-4 w-1/3 text-sm font-medium text-gray-800">Giờ kết thúc</td>
                        <td class="px-6 py-4 text-sm text-gray-700">
                            <fmt:formatDate value="${trip.arrivalTime}" pattern="HH:mm dd-MM-yyyy"/>
                        </td>
                    </tr>

                    <tr class="hover:bg-indigo-50/50 transition">
                        <td class="px-6 py-4 w-1/3 text-sm font-medium text-gray-800">Trạng thái</td>
                        <td class="px-6 py-4 text-sm font-semibold">
                            <c:choose>
                                <c:when test="${trip.status eq 'NOT_STARTED'}">
                                    <span class="text-amber-600">Chưa bắt đầu</span>
                                </c:when>
                                <c:when test="${trip.status eq 'IN_PROCESS'}">
                                    <span class="text-green-600">Đang chạy</span>
                                </c:when>
                                <c:when test="${trip.status eq 'FINISHED'}">
                                    <span class="text-blue-600">Hoàn thành</span>
                                </c:when>
                                <c:when test="${trip.status eq 'CANCELLED'}">
                                    <span class="text-red-500">Đã hủy</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-gray-500">${trip.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>

                </tbody>
            </table>
        </div>

        <div class="flex items-center justify-between mt-8">
            <a href="TripServlet?action=list" class="text-sm font-medium text-indigo-600 hover:underline">
                ← Quay lại danh sách
            </a>
            <a href="TripServlet?action=edit&tripId=${trip.tripId}"
               class="bg-gradient-to-r from-indigo-500 to-purple-500 text-white px-6 py-2.5 rounded-lg shadow-md hover:shadow-lg transition-all duration-200 hover:scale-105">
                ✏️ Chỉnh sửa chuyến này
            </a>
        </div>

    </div>

</body>
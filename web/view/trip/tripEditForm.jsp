<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>

<ui:layout>
    <jsp:attribute name="title">Cập nhật Chuyến (ID: ${trip.tripId}) • VinNoBus</jsp:attribute>

    <jsp:body>
        <%-- Bỏ thẻ <body> và <script> vì layout đã lo --%>
        
        <div class="max-w-2xl mx-auto bg-white/90 backdrop-blur-sm rounded-2xl shadow-md p-8 mt-10">
            
            <h2 class="text-3xl font-bold text-center mb-8 bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent">
                Cập nhật chi tiết chuyến xe (ID: ${trip.tripId})
            </h2>

            <c:if test="${not empty success}">
                 <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded-md mb-6" role="alert">
                    <p class="font-bold">${success}</p>
                </div>
            </c:if>

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

            <form action="TripServlet?action=update" method="post">
                <input type="hidden" name="tripId" value="${trip.tripId}" />

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-5">
                    
                    <%-- 1. CHỌN TUYẾN XE --%>
                    <div>
                         <label for="routeId" class="block mb-2 text-sm font-medium text-gray-900">Tuyến xe:</label>
                        <input type="text" list="routesData" id="routeId" name="routeId" value="${trip.routeId}" required
                               class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-indigo-500 focus:border-indigo-500 block w-full p-2.5"
                               placeholder="Gõ số tuyến hoặc tên để chọn...">
                        <datalist id="routesData">
                            <c:forEach var="route" items="${routesList}">
                                <option value="${route.routeId}">${route.routeName}</option>
                            </c:forEach>
                        </datalist>
                    </div>
                    
                    <%-- 2. CHỌN XE BUÝT --%>
                     <div>
                        <label for="busId" class="block mb-2 text-sm font-medium text-gray-900">Xe buýt:</label>
                        <input type="text" list="busesData" id="busId" name="busId" 
                               value="${trip.busId > 0 ? trip.busId : ''}" 
                               class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-indigo-500 focus:border-indigo-500 block w-full p-2.5"
                               placeholder="Gõ biển số xe để chọn...">
                        <datalist id="busesData">
                             <c:forEach var="bus" items="${busesList}">
                                <option value="${bus.busId}">${bus.plateNumber}</option>
                            </c:forEach>
                        </datalist>
                    </div>
                </div>

                <%-- 3. CHỌN TÀI XẾ --%>
                <div class="mb-5">
                    <label for="driverId" class="block mb-2 text-sm font-medium text-gray-900">Tài xế:</label>
                    <input type="text" list="driversData" id="driverId" name="driverId" value="${trip.driverId}"
                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-indigo-500 focus:border-indigo-500 block w-full p-2.5"
                           placeholder="Gõ tên hoặc mã tài xế...">
                    <datalist id="driversData">
                        <c:forEach var="driver" items="${driversList}">
                            <option value="${driver.userId}">${driver.name} (ID: ${driver.userId})</option>
                        </c:forEach>
                    </datalist>
                </div>

                <%-- 4. CHỌN PHỤ XE --%>
                <div class="mb-5">
                    <label for="conductorId" class="block mb-2 text-sm font-medium text-gray-900">Phụ xe:</label>
                    <input type="text" list="conductorsData" id="conductorId" name="conductorId" value="${trip.conductorId}"
                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-indigo-500 focus:border-indigo-500 block w-full p-2.5"
                           placeholder="Gõ tên hoặc mã phụ xe...">
                    <datalist id="conductorsData">
                        <c:forEach var="conductor" items="${conductorsList}">
                            <option value="${conductor.userId}">${conductor.name} (ID: ${conductor.userId})</option>
                        </c:forEach>
                    </datalist>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                    <div>
                        <label for="departureTime" class="block mb-2 text-sm font-medium text-gray-900">Giờ khởi hành:</label>
                         <input type="datetime-local" id="departureTime" name="departureTime"
                                <c:if test="${not empty trip.departureTime}">
                                   value="<fmt:formatDate value='${trip.departureTime}' pattern='yyyy-MM-dd\'T\'HH:mm'/>"
                                </c:if>
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-indigo-500 focus:border-indigo-500 block w-full p-2.5">
                    </div>
                     <div>
                        <label for="arrivalTime" class="block mb-2 text-sm font-medium text-gray-900">Giờ kết thúc:</label>
                        <input type="datetime-local" id="arrivalTime" name="arrivalTime"
                               <c:if test="${not empty trip.arrivalTime}">
                                   value="<fmt:formatDate value='${trip.arrivalTime}' pattern='yyyy-MM-dd\'T\'HH:mm'/>"
                               </c:if>
                               class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-indigo-500 focus:border-indigo-500 block w-full p-2.5">
                    </div>
                </div>
                
                <div class="mb-6">
                     <label for="status" class="block mb-2 text-sm font-medium text-gray-900">Trạng thái:</label>
                    <select id="status" name="status"
                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-indigo-500 focus:border-indigo-500 block w-full p-2.5">
                        <option value="NOT_STARTED" <c:if test="${trip.status eq 'NOT_STARTED'}">selected</c:if>>Chưa bắt đầu</option>
                         <option value="IN_PROCESS"  <c:if test="${trip.status eq 'IN_PROCESS'}">selected</c:if>>Đang chạy</option>
                        <option value="FINISHED"    <c:if test="${trip.status eq 'FINISHED'}">selected</c:if>>Hoàn thành</option>
                        <option value="CANCELLED"   <c:if test="${trip.status eq 'CANCELLED'}">selected</c:if>>Đã hủy</option>
                    </select>
                </div>
                
                <div class="flex items-center justify-between">
                    <button type="submit"
                            class="bg-gradient-to-r from-indigo-500 to-purple-500 text-white px-6 py-2.5 rounded-lg shadow-md hover:shadow-lg transition-all duration-200 hover:scale-105">
                        💾 Lưu Cập nhật
                    </button>
                    <a href="TripServlet?action=list" class="text-sm font-medium text-indigo-600 hover:underline">
                        ← Quay lại danh sách
                    </a>
                </div>
            </form>
            
            <div class="mt-6 border-t pt-6">
                 <form action="TripServlet" method="post" 
                       onsubmit="return confirm('Bạn có chắc muốn xóa chuyến xe này không? Hành động này không thể hoàn tác.')">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="tripId" value="${trip.tripId}">
                    <button type="submit"
                            class="w-full bg-red-600 text-white px-6 py-2.5 rounded-lg shadow-md hover:bg-red-700 transition-all duration-200">
                        ❌ Xóa chuyến xe này
                    </button>
                </form>
            </div>

        </div>
    </jsp:body>
</ui:layout>
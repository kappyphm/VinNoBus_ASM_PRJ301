<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>

<ui:layout>
    <jsp:attribute name="title">Chi tiết Chuyến xe • VinNoBus</jsp:attribute>

    <jsp:body>
        <main class="min-h-screen bg-brand-50 flex items-center justify-center p-6">
            <div class="w-full max-w-md bg-white rounded-2xl shadow-soft p-6">

                <h1 class="text-xl font-semibold mb-2 text-slate-900">Chi tiết chuyến xe</h1>
                <p class="text-sm text-slate-600 mb-6">Thông tin đầy đủ về chuyến xe trong hệ thống VinNoBus.</p>

                <div class="space-y-3 text-sm text-slate-800">
                    <div class="flex justify-between border-b pb-2">
                        <span class="font-medium text-slate-500">Mã chuyến:</span>
                        <span>${trip.tripId}</span>
                    </div>
                    <div class="flex justify-between border-b pb-2">
                        <span class="font-medium text-slate-500">Mã tuyến:</span>
                        <span>${trip.routeId}</span>
                    </div>
                    <div class="flex justify-between border-b pb-2">
                        <span class="font-medium text-slate-500">Mã xe buýt:</span>
                        <span>${trip.busId}</span>
                    </div>
                    <div class="flex justify-between border-b pb-2">
                        <span class="font-medium text-slate-500">Tài xế:</span>
                        <span>${trip.driverId}</span>
                    </div>
                    <div class="flex justify-between border-b pb-2">
                        <span class="font-medium text-slate-500">Phụ xe:</span>
                        <span>${trip.conductorId}</span>
                    </div>
                    <div class="flex justify-between border-b pb-2">
                        <span class="font-medium text-slate-500">Giờ khởi hành:</span>
                        <span><fmt:formatDate value="${trip.departureTime}" pattern="HH:mm:ss"/></span>
                    </div>
                    <div class="flex justify-between border-b pb-2">
                        <span class="font-medium text-slate-500">Giờ kết thúc:</span>
                        <span><fmt:formatDate value="${trip.arrivalTime}" pattern="HH:mm:ss"/></span>
                    </div>
                    <div class="flex justify-between pb-2">
                        <span class="font-medium text-slate-500">Trạng thái:</span>
                        <span class="
                            px-2 py-1 rounded-xl text-xs font-semibold text-white
                            <c:choose>
                                <c:when test='${trip.status == "NOT_STARTED"}'>bg-slate-500</c:when>
                                <c:when test='${trip.status == "IN_PROGRESS"}'>bg-blue-600</c:when>
                                <c:when test='${trip.status == "COMPLETED"}'>bg-green-600</c:when>
                                <c:when test='${trip.status == "CANCELLED"}'>bg-red-600</c:when>
                                <c:otherwise>bg-slate-500</c:otherwise>
                            </c:choose>
                        ">
                            ${trip.status}
                        </span>
                    </div>
                </div>

                <div class="text-center mt-6">
                    <a href="TripServlet?action=list"
                       class="inline-block px-5 py-2 rounded-xl bg-brand-600 text-white text-sm font-medium shadow-soft hover:bg-brand-700 transition">
                        ← Quay lại danh sách
                    </a>
                </div>

            </div>
        </main>
    </jsp:body>
</ui:layout>

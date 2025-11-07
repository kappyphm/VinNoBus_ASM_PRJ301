<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>

<ui:layout>
    <jsp:attribute name="title">Chi tiết Xe Bus • VinNoBus</jsp:attribute>

    <jsp:body>
        <main class="min-h-screen flex items-center justify-center px-5 py-10">

            <div class="w-full max-w-md bg-white border border-slate-200 rounded-2xl shadow-soft p-6">

                <h1 class="text-xl font-semibold mb-1">Chi tiết Xe Bus</h1>
                <p class="text-sm text-slate-600 mb-6">Thông tin đầy đủ về xe bus trong hệ thống VinNoBus.</p>

                <div class="space-y-4 text-sm">

                    <!-- Bus ID -->
                    <div class="flex justify-between border-b pb-2">
                        <span class="text-slate-500">Bus ID:</span>
                        <span class="font-medium">${bus.busId}</span>
                    </div>

                    <!-- Plate -->
                    <div class="flex justify-between border-b pb-2">
                        <span class="text-slate-500">Biển số xe:</span>
                        <span class="font-medium">${bus.plateNumber}</span>
                    </div>

                    <!-- Capacity -->
                    <div class="flex justify-between border-b pb-2">
                        <span class="text-slate-500">Sức chứa:</span>
                        <span>${bus.capacity} chỗ</span>
                    </div>

                    <!-- Status -->
                    <div class="flex justify-between items-center">
                        <span class="text-slate-500">Trạng thái:</span>
                        <c:set var="statusClass">
                            <c:choose>
                                <c:when test='${bus.currentStatus == "AVAILABLE"}'>bg-green-600</c:when>
                                <c:when test='${bus.currentStatus == "IN_USE"}'>bg-blue-600</c:when>
                                <c:when test='${bus.currentStatus == "MAINTENANCE"}'>bg-yellow-600</c:when>
                                <c:when test='${bus.currentStatus == "BROKEN"}'>bg-red-600</c:when>
                                <c:when test='${bus.currentStatus == "REPAIRING"}'>bg-orange-600</c:when>
                                <c:when test='${bus.currentStatus == "RESERVED"}'>bg-purple-600</c:when>
                                <c:otherwise>bg-slate-500</c:otherwise>
                            </c:choose>
                        </c:set>

                        <span class="px-3 py-1 rounded-xl text-xs font-semibold text-white ${statusClass}">
                            ${bus.currentStatus}
                        </span>
                    </div>
                </div>

                <!-- Back -->
                <div class="text-center mt-8">
                    <a href="BusServlet?action=list"
                       class="inline-block px-5 py-2 rounded-xl bg-brand-600 text-white text-sm font-medium shadow-soft hover:bg-brand-700 transition">
                        ← Quay lại danh sách
                    </a>
                </div>

            </div>

        </main>
    </jsp:body>
</ui:layout>

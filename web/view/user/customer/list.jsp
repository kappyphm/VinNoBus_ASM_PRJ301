<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>

<ui:layout>
    <jsp:attribute name="title">Danh sách khách hàng</jsp:attribute>
    <jsp:body>
        <main class="h-[100vh] max-w-6xl mx-auto px-5 py-10">

            <h1 class="text-2xl font-semibold mb-2">Danh sách khách hàng</h1>
            <p class="text-sm text-slate-600 mb-6">Quản lý thông tin khách hàng trong hệ thống VinNoBus.</p>

            <!-- Toolbar -->
            <form action="${ctx}/customers" method="get" class="flex flex-wrap gap-3 items-center mb-6">
                <input type="text" name="search" placeholder="🔍 Tìm kiếm..." value="${param.search}"
                       class="px-3 py-2 border border-slate-300 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-brand-300">

                <select name="sort" class="px-3 py-2 border border-slate-300 rounded-xl text-sm">
                    <option value="">Sắp xếp theo</option>
                    <option value="name">Tên (A-Z)</option>
                    <option value="email">Email</option>
                    <option value="dob">Ngày sinh</option>
                </select>

                <button type="submit" class="px-3 py-2 bg-brand-600 text-white text-sm rounded-xl hover:bg-brand-700">
                    Tìm kiếm
                </button>

                <a href="${ctx}/customer/create"
                   class="px-3 py-2 bg-brand-100 text-brand-700 text-sm rounded-xl border border-brand-200 hover:bg-brand-200">
                    + Thêm mới
                </a>
            </form>

            <!-- Customer Table -->
            <div class="bg-white rounded-2xl shadow-soft overflow-hidden">
                <table class="w-full text-sm text-left border-collapse">
                    <thead class="bg-brand-100 text-brand-800">
                        <tr>
                            <th class="p-3">ID</th>
                            <th class="p-3">Tên</th>
                            <th class="p-3">Ngày sinh</th>
                            <th class="p-3">Email</th>
                            <th class="p-3">SĐT</th>
                            <th class="p-3">Hạng KH</th>
                            <th class="p-3">Điểm</th>
                            <th class="p-3 text-center">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${userDetails}">
                            <tr class="border-b hover:bg-brand-50">
                                <td class="p-3">${u.id}</td>
                                <td class="p-3">${u.name}</td>
                                <td class="p-3">${u.dob}</td>
                                <td class="p-3">${u.email}</td>
                                <td class="p-3">${u.phone}</td>
                                <td class="p-3">${u.customer.membershipLevel}</td>
                                <td class="p-3">${u.customer.loyaltyPoints}</td>
                                <td class="p-3 text-center">
                                    <a href="${ctx}/customer/detail?id=${u.userId}" class="text-brand-600 hover:underline">Chi tiết</a> |
                                    <a href="${ctx}/customer/delete?id=${u.userId}" class="text-red-500 hover:underline">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <div class="flex justify-center mt-6 gap-2">
                <c:if test="${currentPage > 1}">
                    <a href="${ctx}/customers?page=${currentPage-1}&search=${param.search}&sort=${param.sort}" 
                       class="px-3 py-1 border rounded text-brand-600 hover:bg-brand-100">«</a>
                </c:if>

                <c:forEach var="i" begin="1" end="${totalPages}">
                    <a href="${ctx}/customers?page=${i}&search=${param.search}&sort=${param.sort}" 
                       class="px-3 py-1 border rounded ${i==currentPage?'bg-brand-600 text-white':'text-brand-600 hover:bg-brand-100'}">${i}</a>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="${ctx}/customers?page=${currentPage+1}&search=${param.search}&sort=${param.sort}" 
                       class="px-3 py-1 border rounded text-brand-600 hover:bg-brand-100">»</a>
                </c:if>
            </div>

        </main>
    </jsp:body>
</ui:layout>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>

<ui:layout>
    <jsp:attribute name="title">Quản lý người dùng</jsp:attribute>

    <main class="h-[100vh] max-w-6xl mx-auto px-5 py-10">

        <h1 class="text-2xl font-semibold mb-2">Quản lý người dùng</h1>
        <p class="text-sm text-slate-600 mb-6">Quản lý thông tin nhân viên và khách hàng trong hệ thống VinNoBus.</p>

        <!-- Tabs -->
        <div class="flex gap-3 mb-6">
            <button id="tabCustomer" class="px-4 py-2 rounded-xl text-sm font-medium tab-active">Khách hàng</button>
            <button id="tabStaff" class="px-4 py-2 rounded-xl text-sm font-medium tab-inactive">Nhân viên</button>
        </div>

        <!-- Toolbar -->
        <form action="${ctx}/users" method="get" class="flex flex-wrap gap-3 items-center mb-6">
            <input type="hidden" name="type" id="userType" value="customer">

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

            <a href="${ctx}/user/create"
               class="px-3 py-2 bg-brand-100 text-brand-700 text-sm rounded-xl border border-brand-200 hover:bg-brand-200">
                + Thêm mới
            </a>
        </form>

        <!-- Customer Table -->
        <div id="customerTable" class="bg-white rounded-2xl shadow-soft overflow-hidden">
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
                    <c:forEach var="c" items="${customers}">
                        <tr class="border-b hover:bg-brand-50">
                            <td class="p-3">${c.id}</td>
                            <td class="p-3">${c.name}</td>
                            <td class="p-3">${c.dob}</td>
                            <td class="p-3">${c.email}</td>
                            <td class="p-3">${c.phone}</td>
                            <td class="p-3">${c.membershipLevel}</td>
                            <td class="p-3">${c.loyaltyPoints}</td>
                            <td class="p-3 text-center">
                                <a href="${ctx}/user/detail?id=${c.id}" class="text-brand-600 hover:underline">Sửa</a> |
                                <a href="${ctx}/user/delete?id=${c.id}" class="text-red-500 hover:underline">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Staff Table -->
        <div id="staffTable" class="bg-white rounded-2xl shadow-soft overflow-hidden hidden">
            <table class="w-full text-sm text-left border-collapse">
                <thead class="bg-brand-100 text-brand-800">
                    <tr>
                        <th class="p-3">ID</th>
                        <th class="p-3">Mã NV</th>
                        <th class="p-3">Tên</th>
                        <th class="p-3">Ngày sinh</th>
                        <th class="p-3">Email</th>
                        <th class="p-3">SĐT</th>
                        <th class="p-3">Phòng ban</th>
                        <th class="p-3">Vị trí</th>
                        <th class="p-3 text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${staffs}">
                        <tr class="border-b hover:bg-brand-50">
                            <td class="p-3">${s.id}</td>
                            <td class="p-3">${s.staffCode}</td>
                            <td class="p-3">${s.name}</td>
                            <td class="p-3">${s.dob}</td>
                            <td class="p-3">${s.email}</td>
                            <td class="p-3">${s.phone}</td>
                            <td class="p-3">${s.department}</td>
                            <td class="p-3">${s.position}</td>
                            <td class="p-3 text-center">
                                <a href="${ctx}/staff/detail?id=${s.id}" class="text-brand-600 hover:underline">Sửa</a> |
                                <a href="${ctx}/staff/delete?id=${s.id}" class="text-red-500 hover:underline">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

    </main>

    <!-- Tab Switch Script -->
    <script>
        const tabCustomer = document.getElementById("tabCustomer");
        const tabStaff = document.getElementById("tabStaff");
        const customerTable = document.getElementById("customerTable");
        const staffTable = document.getElementById("staffTable");

        tabCustomer.addEventListener("click", () => {
            tabCustomer.classList.add("tab-active"); tabCustomer.classList.remove("tab-inactive");
            tabStaff.classList.add("tab-inactive"); tabStaff.classList.remove("tab-active");
            customerTable.classList.remove("hidden");
            staffTable.classList.add("hidden");
        });

        tabStaff.addEventListener("click", () => {
            tabStaff.classList.add("tab-active"); tabStaff.classList.remove("tab-inactive");
            tabCustomer.classList.add("tab-inactive"); tabCustomer.classList.remove("tab-active");
            staffTable.classList.remove("hidden");
            customerTable.classList.add("hidden");
        });
    </script>
</ui:layout>
